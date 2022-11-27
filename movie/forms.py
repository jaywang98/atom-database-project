from django import forms
# from django.forms  import ModelForm
from movie.models import User, Movie_rating


class RegisterForm(forms.ModelForm):
    """
    Form used for register
    """
    password_repeat = forms.CharField(max_length=256)

    def get_errors(self):
        errors = self.errors.get_json_data()
        errors_lst = []
        for messages in errors.values():
            for message_dict in messages:
                for key, message in message_dict.items():
                    if key == 'message':
                        errors_lst.append(message)
        return errors_lst

    # Valid password
    def clean(self):
        cleaned_data = super(RegisterForm, self).clean()
        pwd = cleaned_data.get('password')
        password_repeat = cleaned_data.get('password_repeat')
        if pwd != password_repeat:
            raise forms.ValidationError(message='The two passwords entered are inconsistent！')
        return cleaned_data

    class Meta:
        model = User
        fields = ['name', 'password', 'email']


class LoginForm(forms.ModelForm):
    """
    Form used for Login
    """
    name = forms.CharField(max_length=128)
    remember = forms.IntegerField(required=False)

    class Meta:
        model = User
        fields = ['password']

    def get_errors(self):
        errors = self.errors.get_json_data()
        errors_lst = []
        for messages in errors.values():
            for message_dict in messages:
                for key, message in message_dict.items():
                    if key == 'message':
                        errors_lst.append(message)
        return errors_lst


class CommentForm(forms.ModelForm):
    # Check if the score is 0 after form validation is passed
    def clean(self):
        cleaned_data = super(CommentForm, self).clean()
        score = cleaned_data.get('score')
        if score == 0:
            raise forms.ValidationError(message='Rating cannot be empty！')
        else:
            return cleaned_data

    class Meta:
        # Movie ratings, only record ratings and reviews
        model = Movie_rating
        fields = ['score', 'comment']
