# It contains the essential fields and behaviors of the data you’re storing.
# Generally, each model maps to a single database table.
from django.db import models
from django.db.models import Avg
from django.core import validators


class Genre(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'Genre'

    def __str__(self):
        return f"<Genre:{self.name}>"


class Movie(models.Model):
    name = models.CharField(max_length=256)
    imdb_id = models.IntegerField()
    time = models.CharField(max_length=256, blank=True)
    genre = models.ManyToManyField(Genre)
    release_time = models.CharField(max_length=256, blank=True)
    intro = models.TextField(blank=True)
    director = models.CharField(max_length=256, blank=True)
    writers = models.CharField(max_length=256, blank=True)
    actors = models.CharField(max_length=512, blank=True)
    # The similarity between movie and movie
    # The similarity of A to B is same with B to A,，so symmetrical should be True
    movie_similarity = models.ManyToManyField("self", through="Movie_similarity", symmetrical=True)

    class Meta:
        db_table = 'Movie'

    def __str__(self):
        return f"<Movie:{self.name},{self.imdb_id}>"

    def get_score(self):
        # define a method to get average score
        # formate {'score__avg': 3.125}
        result_dct = self.movie_rating_set.aggregate(Avg('score'))
        try:
            result = round(result_dct['score__avg'], 1)
        except TypeError:
            return 0
        else:
            return result

    def get_user_score(self, user):
        return self.movie_rating_set.filter(user=user).values('score')

    def get_score_int_range(self):
        return range(int(self.get_score()))

    def get_genre(self):
        genre_dct = self.genre.all().values('name')
        genre_lst = []
        for dct in genre_dct.values():
            genre_lst.append(dct['name'])
        return genre_lst

    def get_similarity(self, k=5):
        # get 5 most similar movies
        similarity_movies = self.movie_similarity.all()[:k]
        print(similarity_movies)
        # movies=Movie.objects.filter(=similarity_movies)
        # print(movies)
        return similarity_movies


class Movie_similarity(models.Model):
    movie_source = models.ForeignKey(Movie, related_name='movie_source', on_delete=models.CASCADE)
    movie_target = models.ForeignKey(Movie, related_name='movie_target', on_delete=models.CASCADE)
    similarity = models.FloatField()

    class Meta:
        # order of similarity by dec
        ordering = ['-similarity']


class User(models.Model):
    name = models.CharField(max_length=128, unique=True)
    password = models.CharField(max_length=256)
    email = models.EmailField(unique=True)
    rating_movies = models.ManyToManyField(Movie, through="Movie_rating")

    def __str__(self):
        return "<USER:( name: {:},password: {:},email: {:} )>".format(self.name, self.password, self.email)

    class Meta:
        db_table = 'User'


class Movie_rating(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, unique=False)
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE, unique=False)
    score = models.FloatField()
    comment = models.TextField(blank=True)

    class Meta:
        db_table = 'Movie_rating'


class Movie_hot(models.Model):
    # top hot 100 movies
    movie = models.ForeignKey(Movie, on_delete=models.CASCADE)
    rating_number = models.IntegerField()

    class Meta:
        db_table = 'Movie_hot'
        ordering = ['-rating_number']
