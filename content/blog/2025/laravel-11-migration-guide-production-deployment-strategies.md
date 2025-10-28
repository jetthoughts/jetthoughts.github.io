---
dev_to_id: null
title: "Laravel 11 Migration Guide: Complete Production Deployment Strategies"
description: "Master the migration from Laravel 10 to Laravel 11. Complete guide with breaking changes analysis, step-by-step migration, testing strategies, and zero-downtime production deployment."
date: 2025-10-27
created_at: "2025-10-27T12:00:00Z"
edited_at: "2025-10-27T12:00:00Z"
draft: false
tags: ["laravel", "php", "migration", "deployment", "laravel11"]
canonical_url: "https://jetthoughts.com/blog/laravel-11-migration-guide-production-deployment-strategies/"
cover_image: "https://res.cloudinary.com/jetthoughts/image/upload/v1730032800/laravel-11-migration-guide.jpg"
slug: "laravel-11-migration-guide-production-deployment-strategies"
metatags:
  image: "https://res.cloudinary.com/jetthoughts/image/upload/v1730032800/laravel-11-migration-guide.jpg"
  og_title: "Laravel 11 Migration Guide: Complete Production Deployment | JetThoughts"
  og_description: "Master Laravel 11 migration with breaking changes analysis, step-by-step upgrade, testing strategies, production deployment best practices."
  twitter_title: "Laravel 11 Migration Guide: Production Deployment Strategies"
  twitter_description: "Complete guide: Laravel 11 upgrade, breaking changes, testing strategies, zero-downtime production deployment"
---

Laravel 11 introduces the most significant architectural improvements since Laravel 8, marking a pivotal moment for PHP development teams managing production applications. Released in March 2024, Laravel 11 streamlines application structure, enhances performance, and introduces modern PHP 8.2+ features that reduce boilerplate code while improving maintainability and developer productivity.

For teams running Laravel 10 applications in production, migrating to Laravel 11 offers substantial benefits: simplified application structure with 50% fewer files in new projects, improved performance through optimized service container resolution, better developer experience with streamlined configuration, and long-term support extending through February 2026. However, this migration introduces breaking changes that require careful planning to avoid disrupting production systems and user workflows.

This comprehensive guide provides everything PHP development teams need to successfully migrate from Laravel 10 to Laravel 11, including detailed breaking changes analysis, step-by-step migration procedures, comprehensive testing strategies, and production deployment best practices ensuring zero-downtime transitions. Teams evaluating cross-framework patterns can compare Laravel 11 migration complexity with [Django 5.0 enterprise migration strategies](/blog/django-5-enterprise-migration-guide-production-strategies/) to understand similar challenges across PHP and Python ecosystems.

## Breaking Changes Analysis: What Laravel 11 Changes

Laravel 11's improvements come with breaking changes that affect application architecture, configuration management, and framework behavior. Understanding these changes before migration prevents surprises and enables accurate effort estimation. To avoid accumulating new technical debt during migration, review our [Django technical debt cost calculator](/blog/django-technical-debt-cost-calculator-elimination-strategy/)—the same patterns apply to Laravel applications for quantifying debt impact and prioritizing elimination efforts alongside framework upgrades.

**PHP Version Requirements**

Laravel 11 requires PHP 8.2 or higher, representing a significant shift from Laravel 10's PHP 8.1 minimum:

```php
// Laravel 10: PHP 8.1+
// composer.json
{
  "require": {
    "php": "^8.1",
    "laravel/framework": "^10.0"
  }
}

// Laravel 11: PHP 8.2+ REQUIRED
// composer.json
{
  "require": {
    "php": "^8.2",
    "laravel/framework": "^11.0"
  }
}
```

**Impact Assessment:**

- **Hosting environment updates**: Verify production PHP version and update infrastructure
- **Development environment alignment**: Ensure all team members use PHP 8.2+
- **CI/CD pipeline modifications**: Update test runners and deployment scripts
- **Third-party package compatibility**: Audit dependencies for PHP 8.2 support

**Application Structure Simplification**

Laravel 11 dramatically simplifies the default application structure, removing several middleware, service providers, and configuration files:

```php
// Laravel 10: Traditional structure
app/
├── Console/
│   └── Kernel.php                    // ❌ REMOVED in Laravel 11
├── Exceptions/
│   └── Handler.php                   // ❌ REMOVED in Laravel 11
├── Http/
│   ├── Kernel.php                    // ❌ REMOVED in Laravel 11
│   └── Middleware/
│       ├── Authenticate.php
│       ├── RedirectIfAuthenticated.php
│       ├── TrimStrings.php           // ❌ Moved to framework in Laravel 11
│       └── TrustProxies.php          // ❌ Moved to framework in Laravel 11
└── Providers/
    ├── AppServiceProvider.php
    ├── AuthServiceProvider.php       // ❌ REMOVED in Laravel 11
    ├── BroadcastServiceProvider.php  // ❌ REMOVED in Laravel 11
    ├── EventServiceProvider.php      // ❌ REMOVED in Laravel 11
    └── RouteServiceProvider.php      // ❌ REMOVED in Laravel 11

// Laravel 11: Streamlined structure
app/
├── Http/
│   ├── Controllers/
│   └── Middleware/
│       ├── Authenticate.php
│       └── RedirectIfAuthenticated.php
└── Providers/
    └── AppServiceProvider.php        // ✅ Single provider for most apps
```

**Migration Impact:**

```php
// Before (Laravel 10): Multiple service providers
// app/Providers/EventServiceProvider.php
class EventServiceProvider extends ServiceProvider
{
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
    ];

    public function boot()
    {
        Event::listen(
            PodcastProcessed::class,
            [SendPodcastNotification::class, 'handle']
        );
    }
}

// After (Laravel 11): Consolidated in AppServiceProvider
// app/Providers/AppServiceProvider.php
class AppServiceProvider extends ServiceProvider
{
    public function boot()
    {
        // Event listeners now registered here
        Event::listen(
            PodcastProcessed::class,
            [SendPodcastNotification::class, 'handle']
        );

        // Or use closure-based listeners
        Event::listen(function (PodcastProcessed $event) {
            // Handle event directly
        });
    }
}
```

**Route Configuration Changes**

Laravel 11 introduces route-based configuration, eliminating separate configuration files for many features:

```php
// Laravel 10: Separate config files
// config/broadcasting.php
// config/cors.php
// config/filesystems.php
// ... 20+ configuration files

// Laravel 11: Route-based configuration
// bootstrap/app.php
return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            \App\Http\Middleware\HandleInertiaRequests::class,
        ]);

        $middleware->alias([
            'subscribed' => \App\Http\Middleware\EnsureUserIsSubscribed::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        $exceptions->render(function (InvalidOrderException $e) {
            return response('Invalid order', 400);
        });
    })
    ->create();
```

**Middleware Registration Changes**

Laravel 11 moves middleware registration from HTTP Kernel to `bootstrap/app.php`:

```php
// Laravel 10: HTTP Kernel middleware registration
// app/Http/Kernel.php
protected $middleware = [
    \App\Http\Middleware\TrustProxies::class,
    \Fruitcake\Cors\HandleCors::class,
    \App\Http\Middleware\PreventRequestsDuringMaintenance::class,
];

protected $middlewareGroups = [
    'web' => [
        \App\Http\Middleware\EncryptCookies::class,
        \Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse::class,
        \Illuminate\Session\Middleware\StartSession::class,
    ],
];

protected $routeMiddleware = [
    'auth' => \App\Http\Middleware\Authenticate::class,
    'verified' => \Illuminate\Auth\Middleware\EnsureEmailIsVerified::class,
];

// Laravel 11: Fluent middleware registration
// bootstrap/app.php
->withMiddleware(function (Middleware $middleware) {
    // Global middleware
    $middleware->use([
        \Illuminate\Http\Middleware\TrustProxies::class,
        \Illuminate\Http\Middleware\HandleCors::class,
    ]);

    // Middleware groups
    $middleware->web(append: [
        \App\Http\Middleware\CustomMiddleware::class,
    ]);

    $middleware->web(prepend: [
        \App\Http\Middleware\FirstMiddleware::class,
    ]);

    // Route middleware aliases
    $middleware->alias([
        'subscribed' => \App\Http\Middleware\EnsureUserIsSubscribed::class,
        'admin' => \App\Http\Middleware\EnsureUserIsAdmin::class,
    ]);

    // Middleware priority
    $middleware->priority([
        \App\Http\Middleware\FirstMiddleware::class,
        \Illuminate\Session\Middleware\StartSession::class,
    ]);
})
```

**Exception Handling Consolidation**

Laravel 11 consolidates exception handling into `bootstrap/app.php`:

```php
// Laravel 10: Dedicated exception handler
// app/Exceptions/Handler.php
class Handler extends ExceptionHandler
{
    protected $dontReport = [
        InvalidRequestException::class,
    ];

    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    public function register()
    {
        $this->reportable(function (InvalidOrderException $e) {
            // Custom reporting
        });

        $this->renderable(function (NotFoundHttpException $e, $request) {
            if ($request->is('api/*')) {
                return response()->json(['message' => 'Not found'], 404);
            }
        });
    }
}

// Laravel 11: Exception handling in bootstrap/app.php
// bootstrap/app.php
->withExceptions(function (Exceptions $exceptions) {
    // Don't report these exceptions
    $exceptions->dontReport([
        InvalidRequestException::class,
    ]);

    // Don't flash these input fields
    $exceptions->dontFlash([
        'current_password',
        'password',
        'password_confirmation',
    ]);

    // Custom exception reporting
    $exceptions->report(function (InvalidOrderException $e) {
        // Report to external service
        \Sentry\captureException($e);
    });

    // Custom exception rendering
    $exceptions->render(function (NotFoundHttpException $e, Request $request) {
        if ($request->is('api/*')) {
            return response()->json([
                'message' => 'Resource not found',
                'status' => 404
            ], 404);
        }
    });
})
```

**Database Migration Changes**

Laravel 11 modifies default migration behavior:

```php
// Laravel 10: Separate timestamp columns
Schema::create('users', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->timestamps();  // created_at, updated_at
});

// Laravel 11: Optional timestamp precision
use Illuminate\Support\Facades\Schema;

Schema::defaultMorphKeyType('ulid');  // Use ULIDs instead of integers

Schema::create('users', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->timestamps(precision: 6);  // Microsecond precision
});

// Migration squashing improvements
php artisan schema:dump --prune  // Creates single migration file
```

**Model Casts Array Removal**

Laravel 11 deprecates the `$casts` array's `array` cast in favor of `AsArrayObject`:

```php
// Laravel 10: Using 'array' cast
class User extends Model
{
    protected $casts = [
        'metadata' => 'array',  // ⚠️ Deprecated in Laravel 11
    ];
}

// Laravel 11: Using AsArrayObject cast
use Illuminate\Database\Eloquent\Casts\AsArrayObject;

class User extends Model
{
    protected $casts = [
        'metadata' => AsArrayObject::class,  // ✅ Recommended approach
    ];

    // Access as array
    public function example()
    {
        $this->metadata['key'] = 'value';  // Works with AsArrayObject
        return $this->metadata['key'];
    }
}
```

**Eloquent Model `casts` Method**

Laravel 11 introduces the `casts()` method as an alternative to the `$casts` property:

```php
// Laravel 10: Using $casts property
class Post extends Model
{
    protected $casts = [
        'published_at' => 'datetime',
        'is_featured' => 'boolean',
        'metadata' => 'array',
    ];
}

// Laravel 11: Using casts() method
class Post extends Model
{
    protected function casts(): array
    {
        return [
            'published_at' => 'datetime',
            'is_featured' => 'boolean',
            'metadata' => AsArrayObject::class,
        ];
    }

    // Benefit: Dynamic casting based on conditions
    protected function casts(): array
    {
        $casts = [
            'published_at' => 'datetime',
        ];

        if ($this->hasAdvancedFeatures()) {
            $casts['metadata'] = AsEncryptedArrayObject::class;
        }

        return $casts;
    }
}
```

For teams navigating complex Laravel upgrades or requiring strategic guidance on modernizing legacy applications, our [technical leadership consulting](/services/technical-leadership-consulting/) helps evaluate migration readiness, assess breaking change impacts, and develop comprehensive upgrade strategies aligned with business objectives and technical constraints.

## Migration Planning: Pre-Migration Assessment

Successful Laravel 11 migrations begin with comprehensive planning and assessment. Understanding your application's complexity, dependencies, and custom implementations ensures accurate effort estimation and risk mitigation.

**Application Complexity Assessment**

```php
// Create assessment script
// scripts/migration-assessment.php
<?php

require __DIR__.'/../vendor/autoload.php';

$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$assessment = [
    'laravel_version' => app()->version(),
    'php_version' => PHP_VERSION,
    'controllers_count' => count(glob(app_path('Http/Controllers/**/*.php'))),
    'models_count' => count(glob(app_path('Models/*.php'))),
    'migrations_count' => count(glob(database_path('migrations/*.php'))),
    'routes_count' => [
        'web' => count(\Route::getRoutes()->getRoutesByMethod()['GET'] ?? []),
        'api' => count(\Route::getRoutes()->getRoutesByName()),
    ],
    'middleware_count' => count(glob(app_path('Http/Middleware/*.php'))),
    'service_providers' => count(glob(app_path('Providers/*.php'))),
    'tests_count' => count(glob(base_path('tests/**/*Test.php'))),
];

// Identify Laravel 11 breaking changes
$breaking_changes = [
    'http_kernel' => file_exists(app_path('Http/Kernel.php')),
    'console_kernel' => file_exists(app_path('Console/Kernel.php')),
    'exception_handler' => file_exists(app_path('Exceptions/Handler.php')),
    'route_service_provider' => file_exists(app_path('Providers/RouteServiceProvider.php')),
    'auth_service_provider' => file_exists(app_path('Providers/AuthServiceProvider.php')),
    'event_service_provider' => file_exists(app_path('Providers/EventServiceProvider.php')),
    'broadcast_service_provider' => file_exists(app_path('Providers/BroadcastServiceProvider.php')),
];

echo "=== Laravel Migration Assessment ===\n";
echo json_encode($assessment, JSON_PRETTY_PRINT) . "\n\n";
echo "=== Breaking Changes Impact ===\n";
echo json_encode($breaking_changes, JSON_PRETTY_PRINT) . "\n";
```

**Dependency Audit**

```bash
# Check Composer dependencies for Laravel 11 compatibility
composer outdated --direct

# Identify packages requiring updates
composer why-not laravel/framework 11.0

# Common packages requiring updates for Laravel 11:
# - laravel/sanctum: ^4.0
# - laravel/horizon: ^5.21
# - laravel/telescope: ^5.0
# - spatie/laravel-permission: ^6.0
# - barryvdh/laravel-debugbar: ^3.9
```

**Custom Code Audit**

Identify custom implementations that may conflict with Laravel 11 changes:

```php
// Search for deprecated patterns
grep -r "protected \$casts" app/Models/
grep -r "protected \$dates" app/Models/
grep -r "class.*extends.*ServiceProvider" app/Providers/
grep -r "class.*Kernel" app/

// Identify middleware registrations
grep -r "protected \$middleware" app/Http/Kernel.php
grep -r "protected \$middlewareGroups" app/Http/Kernel.php
grep -r "protected \$routeMiddleware" app/Http/Kernel.php

// Find exception handling customizations
grep -r "public function render" app/Exceptions/Handler.php
grep -r "public function report" app/Exceptions/Handler.php
```

**Testing Strategy Development**

```php
// tests/Feature/MigrationSafetyTest.php
namespace Tests\Feature;

use Tests\TestCase;

class MigrationSafetyTest extends TestCase
{
    /**
     * Baseline test: Capture current application behavior
     */
    public function test_baseline_application_routes()
    {
        $routes = collect(\Route::getRoutes())->map(function ($route) {
            return [
                'uri' => $route->uri(),
                'methods' => $route->methods(),
                'name' => $route->getName(),
            ];
        })->toArray();

        // Store baseline for comparison after migration
        file_put_contents(
            storage_path('tests/baseline_routes.json'),
            json_encode($routes, JSON_PRETTY_PRINT)
        );

        $this->assertNotEmpty($routes);
    }

    public function test_baseline_middleware_configuration()
    {
        $middleware = [
            'global' => app(\Illuminate\Contracts\Http\Kernel::class)->getMiddleware(),
            'groups' => app(\Illuminate\Contracts\Http\Kernel::class)->getMiddlewareGroups(),
            'route' => app(\Illuminate\Contracts\Http\Kernel::class)->getRouteMiddleware(),
        ];

        file_put_contents(
            storage_path('tests/baseline_middleware.json'),
            json_encode($middleware, JSON_PRETTY_PRINT)
        );

        $this->assertNotEmpty($middleware);
    }

    public function test_baseline_service_providers()
    {
        $providers = array_map(
            fn($provider) => get_class($provider),
            app()->getProviders()
        );

        file_put_contents(
            storage_path('tests/baseline_providers.json'),
            json_encode($providers, JSON_PRETTY_PRINT)
        );

        $this->assertNotEmpty($providers);
    }
}
```

**Migration Effort Estimation**

```php
// Calculate estimated migration time
$effort_matrix = [
    'small_app' => [
        'characteristics' => [
            'controllers' => '<20',
            'models' => '<10',
            'custom_middleware' => '<5',
            'service_providers' => '<=5',
        ],
        'estimated_hours' => 8,
    ],
    'medium_app' => [
        'characteristics' => [
            'controllers' => '20-50',
            'models' => '10-30',
            'custom_middleware' => '5-15',
            'service_providers' => '5-10',
        ],
        'estimated_hours' => 24,
    ],
    'large_app' => [
        'characteristics' => [
            'controllers' => '>50',
            'models' => '>30',
            'custom_middleware' => '>15',
            'service_providers' => '>10',
        ],
        'estimated_hours' => 60,
    ],
];

// Add complexity multipliers
$complexity_factors = [
    'custom_authentication' => 1.3,
    'custom_authorization' => 1.2,
    'complex_middleware_logic' => 1.4,
    'extensive_service_providers' => 1.5,
    'third_party_package_conflicts' => 1.6,
    'legacy_code_patterns' => 1.8,
];
```

## Step-by-Step Migration from Laravel 10 to Laravel 11

With comprehensive assessment complete, execute the migration through systematic phases ensuring application stability and minimizing risk.

### Phase 1: Environment Preparation

**Update Development Environment**

```bash
# Update PHP version (example for Ubuntu/Debian)
sudo apt update
sudo apt install php8.2 php8.2-fpm php8.2-cli php8.2-mbstring php8.2-xml php8.2-curl

# Verify PHP version
php -v  # Should show PHP 8.2.x

# Update Composer to latest version
composer self-update

# Clear Composer cache
composer clear-cache
```

**Create Migration Branch**

```bash
# Create dedicated migration branch
git checkout -b feature/laravel-11-migration

# Ensure clean working directory
git status

# Document current state
php artisan about > docs/pre-migration-state.txt
```

**Backup Critical Data**

```bash
# Backup database
php artisan db:backup

# Or manual backup
mysqldump -u username -p database_name > backup_pre_migration.sql

# Backup environment configuration
cp .env .env.backup.$(date +%Y%m%d)

# Backup composer.lock for potential rollback
cp composer.lock composer.lock.backup
```

### Phase 2: Composer Dependencies Update

**Update Laravel Framework**

```json
// composer.json - Update Laravel version
{
  "require": {
    "php": "^8.2",
    "laravel/framework": "^11.0",
    "laravel/sanctum": "^4.0",
    "laravel/tinker": "^2.9"
  },
  "require-dev": {
    "fakerphp/faker": "^1.23",
    "laravel/pint": "^1.13",
    "laravel/sail": "^1.26",
    "mockery/mockery": "^1.6",
    "nunomaduro/collision": "^8.0",
    "phpunit/phpunit": "^11.0",
    "spatie/laravel-ignition": "^2.4"
  }
}
```

**Update Dependencies**

```bash
# Update dependencies (may fail due to conflicts - expected)
composer update

# If conflicts occur, update dependencies individually
composer require "laravel/framework:^11.0" --with-all-dependencies
composer require "laravel/sanctum:^4.0" --with-all-dependencies

# Update development dependencies
composer require "phpunit/phpunit:^11.0" --dev --with-all-dependencies
```

**Resolve Package Conflicts**

```bash
# Identify incompatible packages
composer why-not laravel/framework 11.0

# Common packages requiring updates:
composer require spatie/laravel-permission:^6.0
composer require barryvdh/laravel-debugbar:^3.9
composer require spatie/laravel-query-builder:^6.0

# Remove packages no longer compatible (if necessary)
composer remove package/name

# Check for deprecated package replacements
# Some packages may have Laravel 11 alternatives
```

### Phase 3: Application Structure Migration

**Create New Bootstrap Configuration**

```php
// bootstrap/app.php - New Laravel 11 style
<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        // Migrate global middleware from app/Http/Kernel.php
        $middleware->use([
            \Illuminate\Http\Middleware\TrustProxies::class,
            \Illuminate\Http\Middleware\HandleCors::class,
            \Illuminate\Foundation\Http\Middleware\PreventRequestsDuringMaintenance::class,
        ]);

        // Web middleware group customizations
        $middleware->web(append: [
            // Add custom web middleware here
        ]);

        // API middleware group customizations
        $middleware->api(prepend: [
            // Add custom API middleware here
        ]);

        // Route middleware aliases (from $routeMiddleware)
        $middleware->alias([
            'auth' => \App\Http\Middleware\Authenticate::class,
            'verified' => \Illuminate\Auth\Middleware\EnsureEmailIsVerified::class,
            // Add all custom route middleware aliases
        ]);

        // Middleware priority (if customized in Laravel 10)
        $middleware->priority([
            \Illuminate\Session\Middleware\StartSession::class,
            \Illuminate\View\Middleware\ShareErrorsFromSession::class,
            \App\Http\Middleware\Authenticate::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        // Migrate exception handling from app/Exceptions/Handler.php

        // Don't report these exceptions
        $exceptions->dontReport([
            \App\Exceptions\CustomException::class,
        ]);

        // Don't flash these input fields
        $exceptions->dontFlash([
            'current_password',
            'password',
            'password_confirmation',
        ]);

        // Custom exception reporting
        $exceptions->report(function (\Throwable $e) {
            if ($e instanceof \App\Exceptions\CriticalException) {
                // Report to external service
                \Log::critical('Critical exception occurred', [
                    'exception' => $e->getMessage(),
                    'trace' => $e->getTraceAsString(),
                ]);
            }
        });

        // Custom exception rendering
        $exceptions->render(function (\Symfony\Component\HttpKernel\Exception\NotFoundHttpException $e, \Illuminate\Http\Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'message' => 'Resource not found',
                    'status' => 404
                ], 404);
            }
        });
    })
    ->create();
```

**Consolidate Service Providers**

```php
// app/Providers/AppServiceProvider.php - Consolidated provider
<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        // Service container bindings
    }

    public function boot(): void
    {
        // Migrate RouteServiceProvider logic
        $this->bootRoutes();

        // Migrate EventServiceProvider logic
        $this->bootEvents();

        // Migrate AuthServiceProvider logic
        $this->bootAuthorization();

        // Migrate BroadcastServiceProvider logic
        $this->bootBroadcasting();
    }

    protected function bootRoutes(): void
    {
        // Custom route configurations from RouteServiceProvider
        Route::pattern('id', '[0-9]+');
        Route::pattern('uuid', '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}');

        // Model route bindings
        Route::model('user', \App\Models\User::class);
    }

    protected function bootEvents(): void
    {
        // Migrate event listeners from EventServiceProvider
        Event::listen(
            \App\Events\OrderShipped::class,
            \App\Listeners\SendShipmentNotification::class,
        );

        // Closure-based event listeners
        Event::listen(function (\App\Events\PodcastProcessed $event) {
            // Handle event
        });
    }

    protected function bootAuthorization(): void
    {
        // Migrate authorization gates from AuthServiceProvider
        Gate::define('update-post', function ($user, $post) {
            return $user->id === $post->user_id;
        });

        Gate::define('delete-post', function ($user, $post) {
            return $user->id === $post->user_id || $user->isAdmin();
        });
    }

    protected function bootBroadcasting(): void
    {
        // Migrate broadcasting channel authorizations
        \Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
            return (int) $user->id === (int) $id;
        });

        \Broadcast::channel('chat.{roomId}', function ($user, $roomId) {
            return $user->canAccessChatRoom($roomId);
        });
    }
}
```

**Update Model Casts**

```php
// app/Models/User.php - Update deprecated casts
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\AsArrayObject;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    // Before: Using deprecated 'array' cast
    // protected $casts = [
    //     'metadata' => 'array',
    // ];

    // After: Using AsArrayObject cast
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'metadata' => AsArrayObject::class,  // ✅ Laravel 11 recommended
            'preferences' => AsArrayObject::class,
        ];
    }

    // Alternative: Keep $casts property but update cast type
    // protected $casts = [
    //     'email_verified_at' => 'datetime',
    //     'metadata' => AsArrayObject::class,
    // ];
}
```

**Remove Deprecated Files**

After migrating functionality, remove deprecated files:

```bash
# DO NOT DELETE IMMEDIATELY - Keep for reference during testing
# Move to temporary backup directory first

mkdir -p storage/migration-backup

# Backup files for potential restoration
cp app/Http/Kernel.php storage/migration-backup/
cp app/Console/Kernel.php storage/migration-backup/
cp app/Exceptions/Handler.php storage/migration-backup/
cp app/Providers/RouteServiceProvider.php storage/migration-backup/
cp app/Providers/AuthServiceProvider.php storage/migration-backup/
cp app/Providers/EventServiceProvider.php storage/migration-backup/
cp app/Providers/BroadcastServiceProvider.php storage/migration-backup/

# Only delete after thorough testing confirms migration success
# rm app/Http/Kernel.php
# rm app/Console/Kernel.php
# rm app/Exceptions/Handler.php
# ... etc
```

### Phase 4: Configuration and Testing

**Update Configuration Files**

```php
// config/app.php - Review provider registrations
'providers' => ServiceProvider::defaultProviders()->merge([
    // Application Service Providers (consolidated in Laravel 11)
    App\Providers\AppServiceProvider::class,
    // Remove other default providers - they're auto-registered now
])->toArray(),
```

**Run Migration Tests**

```bash
# Clear all caches
php artisan optimize:clear

# Regenerate autoload files
composer dump-autoload

# Run migrations to ensure database compatibility
php artisan migrate:fresh --seed

# Run test suite
php artisan test

# Run specific migration safety tests
php artisan test --filter=MigrationSafetyTest
```

**Validate Middleware Configuration**

```php
// tests/Feature/MiddlewareConfigurationTest.php
namespace Tests\Feature;

use Tests\TestCase;

class MiddlewareConfigurationTest extends TestCase
{
    public function test_middleware_configuration_matches_baseline()
    {
        // Load baseline middleware configuration
        $baseline = json_decode(
            file_get_contents(storage_path('tests/baseline_middleware.json')),
            true
        );

        // Get current middleware configuration
        $current = [
            'global' => app(\Illuminate\Contracts\Http\Kernel::class)->getMiddleware(),
            'groups' => app(\Illuminate\Contracts\Http\Kernel::class)->getMiddlewareGroups(),
            'route' => app(\Illuminate\Contracts\Http\Kernel::class)->getRouteMiddleware(),
        ];

        // Compare configurations
        $this->assertEquals(
            count($baseline['global']),
            count($current['global']),
            'Global middleware count mismatch after migration'
        );

        $this->assertEquals(
            count($baseline['route']),
            count($current['route']),
            'Route middleware count mismatch after migration'
        );
    }

    public function test_custom_middleware_still_registered()
    {
        $routeMiddleware = app(\Illuminate\Contracts\Http\Kernel::class)
            ->getRouteMiddleware();

        // Verify custom middleware aliases still exist
        $this->assertArrayHasKey('subscribed', $routeMiddleware);
        $this->assertArrayHasKey('admin', $routeMiddleware);
        $this->assertArrayHasKey('verified', $routeMiddleware);
    }
}
```

**Compare Route Definitions**

```php
// tests/Feature/RouteConfigurationTest.php
namespace Tests\Feature;

use Tests\TestCase;

class RouteConfigurationTest extends TestCase
{
    public function test_all_routes_preserved_after_migration()
    {
        $baseline = json_decode(
            file_get_contents(storage_path('tests/baseline_routes.json')),
            true
        );

        $current = collect(\Route::getRoutes())->map(function ($route) {
            return [
                'uri' => $route->uri(),
                'methods' => $route->methods(),
                'name' => $route->getName(),
            ];
        })->toArray();

        $this->assertCount(
            count($baseline),
            $current,
            'Route count changed after migration'
        );

        // Verify critical routes still exist
        $currentUris = collect($current)->pluck('uri')->toArray();

        $this->assertContains('/', $currentUris);
        $this->assertContains('api/users', $currentUris);
        $this->assertContains('login', $currentUris);
    }
}
```

### Phase 5: Production Readiness Validation

**Performance Benchmarking**

```php
// tests/Performance/MigrationPerformanceTest.php
namespace Tests\Performance;

use Tests\TestCase;
use Illuminate\Support\Facades\DB;

class MigrationPerformanceTest extends TestCase
{
    public function test_application_bootstrap_time()
    {
        $iterations = 100;
        $times = [];

        for ($i = 0; $i < $iterations; $i++) {
            $start = microtime(true);

            // Bootstrap application
            $app = require __DIR__.'/../../bootstrap/app.php';
            $app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

            $times[] = microtime(true) - $start;

            unset($app);
        }

        $average = array_sum($times) / count($times);

        // Laravel 11 should bootstrap faster due to simplified structure
        $this->assertLessThan(
            0.05,  // 50ms threshold
            $average,
            "Application bootstrap too slow: {$average}s average"
        );

        dump("Average bootstrap time: " . round($average * 1000, 2) . "ms");
    }

    public function test_route_resolution_performance()
    {
        $routes = \Route::getRoutes();
        $iterations = 1000;

        $start = microtime(true);

        for ($i = 0; $i < $iterations; $i++) {
            $routes->match(
                request()->create('/api/users', 'GET')
            );
        }

        $duration = microtime(true) - $start;
        $avgPerRequest = $duration / $iterations;

        $this->assertLessThan(
            0.001,  // 1ms per route resolution
            $avgPerRequest,
            "Route resolution too slow: " . ($avgPerRequest * 1000) . "ms average"
        );
    }
}
```

After migration, establish comprehensive performance monitoring using our [Laravel APM tools comparison guide](/blog/laravel-performance-monitoring-complete-apm-comparison-guide/) to validate improvements, track Laravel 11's performance gains, and detect any post-migration bottlenecks in production environments.

## Production Deployment: Zero-Downtime Strategies

Deploying Laravel 11 upgrades to production requires careful orchestration to maintain service availability and ensure rapid rollback capability if issues arise.

**Blue-Green Deployment Strategy**

```bash
#!/bin/bash
# deploy-laravel-11.sh - Blue-green deployment script

set -e

# Configuration
BLUE_DIR="/var/www/laravel-app-blue"
GREEN_DIR="/var/www/laravel-app-green"
CURRENT_LINK="/var/www/laravel-app"
BACKUP_DIR="/var/www/backups/$(date +%Y%m%d-%H%M%S)"

# Determine current and target environments
if [ -L "$CURRENT_LINK" ]; then
    CURRENT=$(readlink "$CURRENT_LINK")
    if [ "$CURRENT" = "$BLUE_DIR" ]; then
        TARGET_DIR="$GREEN_DIR"
        TARGET_NAME="green"
    else
        TARGET_DIR="$BLUE_DIR"
        TARGET_NAME="blue"
    fi
else
    TARGET_DIR="$GREEN_DIR"
    TARGET_NAME="green"
fi

echo "Deploying Laravel 11 to $TARGET_NAME environment..."

# Deploy new code to target environment
git clone https://github.com/yourorg/laravel-app.git "$TARGET_DIR"
cd "$TARGET_DIR"
git checkout feature/laravel-11-migration

# Install dependencies
composer install --no-dev --optimize-autoloader

# Copy environment configuration
cp "$CURRENT_LINK/.env" "$TARGET_DIR/.env"

# Run migrations (with backup)
php artisan down --message="Upgrading to Laravel 11" --retry=60
php artisan migrate --force

# Optimize for production
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Warm up application
php artisan cache:warm

# Health check
if curl -f http://localhost:8080/up; then
    echo "Health check passed"
else
    echo "Health check failed - rolling back"
    php artisan migrate:rollback --force
    php artisan up
    exit 1
fi

# Switch traffic to new environment
ln -sfn "$TARGET_DIR" "$CURRENT_LINK"

# Reload PHP-FPM
sudo systemctl reload php8.2-fpm

# Bring application up
php artisan up

echo "Deployment complete - now serving from $TARGET_NAME environment"
echo "Old environment preserved at $CURRENT for rollback if needed"
```

**Rolling Deployment with Load Balancer**

```yaml
# .github/workflows/deploy-laravel-11.yml
name: Deploy Laravel 11 to Production

on:
  push:
    branches: [feature/laravel-11-migration]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup PHP 8.2
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.2'
          extensions: mbstring, xml, ctype, json, bcmath

      - name: Install Dependencies
        run: composer install --no-dev --optimize-autoloader

      - name: Run Tests
        run: php artisan test

      - name: Deploy to Server 1
        run: |
          # Remove server 1 from load balancer
          aws elb deregister-instances-from-load-balancer \
            --load-balancer-name laravel-lb \
            --instances ${{ secrets.SERVER_1_INSTANCE_ID }}

          # Deploy to server 1
          ssh deploy@server1 'bash deploy-laravel-11.sh'

          # Health check
          sleep 30
          curl -f https://server1.internal/up || exit 1

          # Re-register server 1 with load balancer
          aws elb register-instances-with-load-balancer \
            --load-balancer-name laravel-lb \
            --instances ${{ secrets.SERVER_1_INSTANCE_ID }}

      - name: Deploy to Server 2
        run: |
          # Repeat for server 2
          aws elb deregister-instances-from-load-balancer \
            --load-balancer-name laravel-lb \
            --instances ${{ secrets.SERVER_2_INSTANCE_ID }}

          ssh deploy@server2 'bash deploy-laravel-11.sh'

          sleep 30
          curl -f https://server2.internal/up || exit 1

          aws elb register-instances-with-load-balancer \
            --load-balancer-name laravel-lb \
            --instances ${{ secrets.SERVER_2_INSTANCE_ID }}

      - name: Deployment Verification
        run: |
          # Verify all servers running Laravel 11
          curl -s https://app.example.com/up | grep "OK"

      - name: Notify Team
        if: success()
        run: |
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -H 'Content-Type: application/json' \
            -d '{"text":"Laravel 11 deployment successful ✅"}'
```

**Monitoring Post-Deployment**

For comprehensive post-deployment monitoring and health checks, teams considering framework switches can compare Laravel 11 features with [Django 5.0 enterprise capabilities](/blog/django-5-enterprise-migration-guide-production-strategies/) to evaluate similar async improvements, ORM optimizations, and deployment strategies across frameworks.

```php
// app/Console/Commands/MonitorDeployment.php
namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class MonitorDeployment extends Command
{
    protected $signature = 'deployment:monitor {duration=300}';
    protected $description = 'Monitor application health after deployment';

    public function handle()
    {
        $duration = $this->argument('duration');
        $endTime = now()->addSeconds($duration);

        $this->info("Monitoring deployment for {$duration} seconds...");

        $metrics = [
            'error_count' => 0,
            'slow_queries' => 0,
            'memory_spikes' => 0,
            'failed_requests' => 0,
        ];

        while (now()->lt($endTime)) {
            // Check error logs
            $recentErrors = DB::table('error_logs')
                ->where('created_at', '>', now()->subMinutes(5))
                ->count();

            if ($recentErrors > 10) {
                $metrics['error_count']++;
                $this->warn("High error rate detected: {$recentErrors} errors in last 5 minutes");
            }

            // Check slow queries
            $slowQueries = DB::table('slow_query_log')
                ->where('query_time', '>', 1)
                ->where('created_at', '>', now()->subMinutes(5))
                ->count();

            if ($slowQueries > 5) {
                $metrics['slow_queries']++;
                $this->warn("Slow queries detected: {$slowQueries} queries over 1s");
            }

            // Check memory usage
            $memoryUsage = memory_get_usage(true) / 1024 / 1024;
            if ($memoryUsage > 512) {  // 512MB threshold
                $metrics['memory_spikes']++;
                $this->warn("High memory usage: {$memoryUsage}MB");
            }

            // Check application health endpoint
            try {
                $response = Http::timeout(5)->get(config('app.url') . '/up');
                if (!$response->successful()) {
                    $metrics['failed_requests']++;
                    $this->error("Health check failed with status: {$response->status()}");
                }
            } catch (\Exception $e) {
                $metrics['failed_requests']++;
                $this->error("Health check failed: {$e->getMessage()}");
            }

            sleep(10);  // Check every 10 seconds
        }

        // Summary
        $this->info("\n=== Deployment Monitoring Summary ===");
        $this->table(
            ['Metric', 'Count'],
            collect($metrics)->map(fn($value, $key) => [$key, $value])
        );

        // Determine if deployment is healthy
        $isHealthy = $metrics['error_count'] < 3
            && $metrics['slow_queries'] < 5
            && $metrics['failed_requests'] < 2;

        if ($isHealthy) {
            $this->info("\n✅ Deployment appears healthy");
            return 0;
        } else {
            $this->error("\n⚠️  Deployment health concerns detected - consider rollback");
            return 1;
        }
    }
}
```

For complex Laravel applications requiring expert migration execution and production deployment support, our [expert application development team](/services/app-web-development/) provides comprehensive Laravel upgrade services, including migration planning, code modernization, testing strategy development, and zero-downtime production deployment with 24/7 post-deployment monitoring.

## Troubleshooting Common Migration Issues

Even with careful planning, Laravel 11 migrations can encounter challenges. This section addresses the most common issues and their solutions.

**Issue 1: Middleware Not Registered**

```php
// Symptom: Error "Target class [custom.middleware] does not exist"

// Cause: Middleware not registered in new bootstrap/app.php structure

// Solution: Add middleware aliases in bootstrap/app.php
return Application::configure(basePath: dirname(__DIR__))
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->alias([
            'custom.middleware' => \App\Http\Middleware\CustomMiddleware::class,
            'subscribed' => \App\Http\Middleware\EnsureUserIsSubscribed::class,
            // Add ALL custom middleware aliases from old Kernel.php
        ]);
    })
    ->create();
```

**Issue 2: Service Provider Methods Not Called**

```php
// Symptom: Boot/register methods in custom providers not executing

// Cause: Provider not registered in config/app.php

// Solution: Ensure provider is registered
// config/app.php
'providers' => ServiceProvider::defaultProviders()->merge([
    App\Providers\AppServiceProvider::class,
    App\Providers\CustomServiceProvider::class,  // Add custom providers
])->toArray(),
```

**Issue 3: Routes Not Found After Migration**

```bash
# Symptom: 404 errors on previously working routes

# Cause: Route caching issues or route file not loaded

# Solution: Clear route cache and verify route loading
php artisan route:clear
php artisan route:list  # Verify routes are loaded

# Check bootstrap/app.php route configuration
->withRouting(
    web: __DIR__.'/../routes/web.php',
    api: __DIR__.'/../routes/api.php',
    commands: __DIR__.'/../routes/console.php',
    health: '/up',
)
```

**Issue 4: Model Casts Throwing Errors**

```php
// Symptom: Error "Call to undefined method array()"

// Cause: Using deprecated 'array' cast

// Solution: Update to AsArrayObject
use Illuminate\Database\Eloquent\Casts\AsArrayObject;

protected function casts(): array
{
    return [
        'metadata' => AsArrayObject::class,  // Instead of 'array'
    ];
}
```

**Issue 5: Exception Handling Not Working**

```php
// Symptom: Custom exception handling not triggering

// Cause: Exception handlers not migrated to bootstrap/app.php

// Solution: Add exception handlers in bootstrap/app.php
->withExceptions(function (Exceptions $exceptions) {
    $exceptions->render(function (\Throwable $e, Request $request) {
        // Custom exception rendering logic
        if ($e instanceof CustomException) {
            return response()->json(['error' => $e->getMessage()], 400);
        }
    });
})
```

## FAQ: Laravel 11 Migration

**Q: Can I migrate to Laravel 11 without upgrading to PHP 8.2?**

A: No. Laravel 11 requires PHP 8.2 or higher. You must upgrade your PHP version first:

```bash
# Check current PHP version
php -v

# Upgrade PHP (Ubuntu/Debian example)
sudo apt install php8.2 php8.2-fpm
```

**Q: How long does a typical Laravel 10 → 11 migration take?**

A: Migration time varies by application complexity:

- **Small apps** (< 20 controllers): 8-16 hours
- **Medium apps** (20-50 controllers): 24-40 hours
- **Large apps** (> 50 controllers): 60-120 hours

**Q: Will Laravel 10 applications continue to receive security updates?**

A: Yes. Laravel 10 receives security fixes until February 2025 and bug fixes until August 2025. However, Laravel 11 receives support until February 2026.

**Q: Can I keep Kernel.php files during migration?**

A: Yes, temporarily. Laravel 11 will use them if present. However, for full Laravel 11 benefits, migrate to the new `bootstrap/app.php` structure.

**Q: What if third-party packages aren't Laravel 11 compatible?**

A: Options include:

1. Wait for package updates
2. Fork and update packages yourself
3. Find alternative packages
4. Delay migration until packages are ready

```bash
# Check package compatibility
composer why-not laravel/framework 11.0

# Update packages
composer require vendor/package:^version
```

**Q: How do I test the migration without affecting production?**

A: Use staged rollout approach:

1. Test in development environment
2. Deploy to staging environment
3. Run comprehensive tests
4. Deploy to production with blue-green strategy
5. Monitor closely and rollback if needed

**Q: Can I roll back to Laravel 10 after deploying Laravel 11?**

A: Yes, with proper backup strategy:

```bash
# Maintain Laravel 10 backup
cp -r /var/www/laravel-app /var/www/laravel-app-backup-l10

# Restore if needed
rm -rf /var/www/laravel-app
cp -r /var/www/laravel-app-backup-l10 /var/www/laravel-app
php artisan migrate:rollback
```

---

Migrating from Laravel 10 to Laravel 11 represents a significant application modernization opportunity, delivering streamlined architecture, improved performance, and enhanced developer experience. The benefits—50% fewer boilerplate files, faster service container resolution, simplified configuration management, and extended long-term support—make this upgrade worthwhile for most PHP applications in production.

Success requires systematic execution: comprehensive pre-migration assessment identifying breaking changes and dependencies, careful step-by-step migration preserving application functionality, thorough testing validating behavior consistency, and zero-downtime production deployment with comprehensive monitoring and instant rollback capability.

Start with detailed assessment using the provided scripts, follow the phase-based migration guide, implement robust testing strategies, and deploy using blue-green or rolling deployment approaches. The investment in Laravel 11 migration pays dividends through simplified codebase maintenance, improved application performance, reduced configuration complexity, and access to modern PHP 8.2+ features.

For teams undertaking complex Laravel migrations requiring strategic planning and expert execution, our [expert application development team](/services/app-web-development/) provides comprehensive Laravel upgrade services, from initial assessment through production deployment and post-migration optimization, ensuring successful outcomes while maintaining business continuity and system reliability.

**JetThoughts Team** specializes in Laravel application modernization and PHP ecosystem best practices. We help development teams navigate complex framework upgrades while maintaining application stability and delivering continuous business value.
