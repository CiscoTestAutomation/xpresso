import os

from django.utils.translation import ugettext_lazy as _

# Django secret key
# (django fails to start without this)
# (we should not be using this feature in internal source codes)
SECRET_KEY = 'xbd7o9ud=aez#^q4nf#z4f&41_k)760!cqncb!=ynec#og_l_v'

# source code location
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# don't run with debug turned on in production!
DEBUG = True

# allow all by default
ALLOWED_HOSTS = ['*']

# root url conf module
ROOT_URLCONF = 'urls'

# Password validation
# (no password validation in micro service)
AUTH_PASSWORD_VALIDATORS = []

# Internationalization
# (microservices save and store in UTC format by default)
TIME_ZONE = 'UTC'
USE_TZ = True
LANGUAGE_CODE = 'en-us'
USE_I18N = True
USE_L10N = True

LOCALE_PATHS = [
    os.path.join(os.path.abspath(BASE_DIR), 'locale'),
]

LANGUAGES = (
    ("en", _("English")),
)

# wsgi hosting
WSGI_APPLICATION = 'wsgi.application'

# Application definition
# ----------------------
INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.staticfiles',
    'rest_framework',
    'settings_mgr',
    'logs_mgr',
    'container_mgmt',
    'exception_mgr',
    'django_probes',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
]

TEMPLATES = []

# rest framework
# --------------
REST_FRAMEWORK = {
    'DATETIME_FORMAT': '%Y-%m-%dT%H:%M:%S.%fZ',

    'DEFAULT_PAGINATION_CLASS':
        'rest_framework.pagination.LimitOffsetPagination',

    'PAGE_SIZE': 10,

    'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
        'rest_framework_xml.parsers.XMLParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser'
    ),

    'DEFAULT_RENDERER_CLASSES': (
        'rest_framework.renderers.JSONRenderer',
        'rest_framework_xml.renderers.XMLRenderer',
    ),
}

# Database
# --------
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 's3_management',
        'HOST': 'database',
        'USER': 's3_admin',
        'PASSWORD': 's3_PaSsW0Rd'
    },

}

# Static files
# ------------
STATIC_URL = '/static/'

# cache setting
# -------------
# CACHES = {}

APPEND_SLASH=False


# microservices logs settings
# ---------------------------
MICROSERVICES_LOGS_ROOT = '/s3/logs'

# Logs
# ----
# this service logs to management directory, unlike all other services which
# assumes that /s3/logs/ dir is their logging directory
LOGGING_ROOT = os.environ.get('SERVICE_LOGS_DIR', '/s3/logs/management')

LOGGING = {
    
}

# Cisco OAuth Registry - COAR
# ---------------------------
COAR_CONSUMER_KEY = "b8a41230-8330-4fe4-b183-ad648f19869d"
COAR_CONSUMER_SECRET = "W59XitgBYGLDGK94TD2PmHcQhvmlYTXF"
COAR_CONSUMER_ID = "kel2"