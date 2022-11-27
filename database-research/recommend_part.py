import csv
import time
import os.path
from math import sqrt
from django.contrib import messages
from django.db.models import Avg, Count, Max
from django.http import HttpResponse, request
from django.shortcuts import render, redirect, reverse
# from .forms import RegisterForm, LoginForm, CommentForm
from django.views.generic import View, ListView, DetailView
from models import User, Movie


class RecommendMovieView(ListView):
    model = Movie
    template_name = 'movie/recommend.html'
    paginate_by = 15
    context_object_name = 'movies'
    ordering = 'movie_rating__score'
    page_kwarg = 'p'

    def __init__(self):
        super().__init__()
        # Top 20 similar user
        self.K = 20
        # Recommend 10 movies
        self.N = 10
        # save rated movies by the current user
        self.cur_user_movie_qs = None

    def get_user_sim(self):
        # User Similarity Dict, format: { user_id1:val , user_id2:val , ... }
        user_sim_dct = dict()
        '''Get the similarity among users, saved in the user_sim_dct'''
        cur_user_id = self.request.session['user_id']
        cur_user = User.objects.get(pk=cur_user_id)
        other_users = User.objects.exclude(pk=cur_user_id)

        self.cur_user_movie_qs = Movie.objects.filter(user=cur_user)

        # Calculate the interation of rated movies between current user and others
        for other_user in other_users:
            # record other user interest number
            user_sim_dct[other_user.id] = len(Movie.objects.filter(user=other_user) & self.cur_user_movie_qs)

        # Order value by key, and return most similar K users.
        print("user similarity calculated!")

        # Format: [ (user, value), (user, value), ... ]
        return sorted(user_sim_dct.items(), key=lambda x: -x[1])[:self.K]

    def get_recommend_movie(self, user_lst):
        # Movie interest dict, format: { movie:value, movie:value , ...}
        movie_val_dct = dict()

        # User，Similarity
        for user, _ in user_lst:
            # Get movies rated by similar users and not in the rating list of previous users,
            # plus the score field to facilitate the calculation of interest values.
            movie_set = Movie.objects.filter(user=user).exclude(id__in=self.cur_user_movie_qs).annotate(
                score=Max('movie_rating__score'))
            for movie in movie_set:
                movie_val_dct.setdefault(movie, 0)
                # Cumulative user ratings
                movie_val_dct[movie] += movie.score
        print('recommend movie list calculated!')
        return sorted(movie_val_dct.items(), key=lambda x: -x[1])[:self.N]

    def get_queryset(self):
        s = time.time()
        # Get most similar k user list
        user_lst = self.get_user_sim()
        # Get recommend movies' id
        movie_lst = self.get_recommend_movie(user_lst)
        print(movie_lst)
        result_lst = []
        for movie, _ in movie_lst:
            result_lst.append(movie)
        e = time.time()
        print(f"Runtime: {e - s}")
        return result_lst

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super(RecommendMovieView, self).get_context_data(*kwargs)
        paginator = context.get('paginator')
        page_obj = context.get('page_obj')
        pagination_data = self.get_pagination_data(paginator, page_obj)
        context.update(pagination_data)
        return context

    def get_pagination_data(self, paginator, page_obj, around_count=2):
        current_page = page_obj.number

        if current_page <= around_count + 2:
            left_pages = range(1, current_page)
            left_has_more = False
        else:
            left_pages = range(current_page - around_count, current_page)
            left_has_more = True

        if current_page >= paginator.num_pages - around_count - 1:
            right_pages = range(current_page + 1, paginator.num_pages + 1)
            right_has_more = False
        else:
            right_pages = range(current_page + 1, current_page + 1 + around_count)
            right_has_more = True
        return {
            'left_pages': left_pages,
            'right_pages': right_pages,
            'current_page': current_page,
            'left_has_more': left_has_more,
            'right_has_more': right_has_more
        }