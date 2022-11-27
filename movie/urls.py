from django.urls import path, reverse
from . import views

app_name = 'movie'

urlpatterns = [
    # default index
    path('', views.IndexView.as_view(), name='index'),

    # hot movies
    path('hot', views.PopularMovieView.as_view(), name='hot'),

    # login
    path('login', views.LoginView.as_view(), name='login'),

    # logout
    path('logout', views.UserLogout, name='logout'),

    # register
    path('register', views.RegisterView.as_view(), name='register'),

    # tag check
    path('tag', views.TagView.as_view(), name='tag'),

    # search function
    path('search', views.SearchView.as_view(), name='search'),

    # movie detail
    path('detail/<int:pk>', views.MovieDetailView.as_view(), name='detail'),

    # rate history
    path('history/<int:pk>', views.RatingHistoryView.as_view(),name='history'),

    # detail log
    path('del_rec/<int:pk>', views.delete_recode, name='delete_record'),

    # recommend page
    path('recommend', views.RecommendMovieView.as_view(),name='recommend'),

    # similarity
    # path('calc_movie_similarity',views.calc_movie_similarity,name='calc_similarity')

]
