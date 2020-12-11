import os

from django.utils.translation import ugettext_lazy as _

# Django secret key
# (django fails to start without this)
# (we should not be using this feature in internal source codes)
SECRET_KEY = 'ingh@z0l($25krankw@=b#&5xoq&txi1lj(4qny$0t@=k-_v2^'

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
        'USER': 'xpresso_admin',
        'PASSWORD': 'XPRESS0_123'
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
LOGGING_ROOT = os.environ.get('SERVICE_LOGS_DIR', '/tmp')
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'simple': {
            'format':'%(asctime)s [%(levelname)s]: %(message)s',
            'datefmt':'%d/%m/%Y %H:%M:%S'
        },
        'verbose': {
            'format':'%(asctime)s [%(levelname)s] %(name)s.%(funcName)s(): %(message)s',
            'datefmt':'%d/%m/%Y %H:%M:%S'
        },
    },
    'handlers': {
        'console': {
            'formatter': 'verbose',
            'class': 'logging.StreamHandler',
        },
        'ServiceFileHandler': {
            'formatter':'verbose',
            'class':'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 's3.log'),
            'maxBytes': 1024*1024*1024,
            'backupCount': 5,
        },
        'ErrorFileHandler': {
            'formatter':'verbose',
            'class':'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(LOGGING_ROOT, 'error.log'),
            'maxBytes': 1024*1024*1024,
            'backupCount': 5,
        },
    },
    'loggers': {
        'gunicorn.access': {
            'handlers': ['ServiceFileHandler', 'console'],
            'level': 'DEBUG',
            'propagate': False,
        },
        'gunicorn.error': {
            'handlers': ['ErrorFileHandler'],
            'level': 'DEBUG',
            'propagate': False,
        },
        'aiohttp.server': {
            'handlers': ['ErrorFileHandler'],
            'level': 'DEBUG',
            'propagate': False,
        },
        '': {
            'handlers': ['ServiceFileHandler', 'console'],
            'level': 'DEBUG',
            'propagate': False,
        },
    }
}

# Cisco OAuth Registry - COAR
# ---------------------------
COAR_CONSUMER_KEY = ""
COAR_CONSUMER_SECRET = ""
COAR_CONSUMER_ID = ""