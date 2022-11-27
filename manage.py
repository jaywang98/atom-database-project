#!/usr/bin/env python
import os
import sys

# django-admin is Django’s command-line utility for administrative tasks.
# In addition, manage.py is automatically created in each Django project. It does the same thing as django-admin
# but also sets the DJANGO_SETTINGS_MODULE environment variable so that it points to your project’s settings.py file.
if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Movie_recommendation_system.settings")
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)
