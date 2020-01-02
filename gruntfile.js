module.exports = function(grunt) {
    grunt.initConfig({
        cssmin: {
            sitecss: {
                files: {
                    'dist/assets/css/styles-1.0.0.min.css': [
                        'node_modules/bootswatch/paper/bootstrap.css',
                        'node_modules/animate.css/animate.css',
                        'node_modules/font-awesome/css/font-awesome.css',
                        'node_modules/toastr/toastr.css',
                        'bower_components/ngImgCrop/compile/minified/ng-img-crop.css',
                        'dev/css/styles.css'
                    ]
                }
            }
        },
        uglify: {
            options: {
                compress: true,
                mangle: false
            },
            applib: {
                src: [
                    'node_modules/jquery/dist/jquery.js',
                    'node_modules/bootstrap/dist/js/bootstrap.js',
                    'bower_components/angular/angular.js',
                    'bower_components/angular-route/angular-route.js',
                    'bower_components/firebase/firebase.js',
                    'bower_components/angularfire/dist/angularfire.js',
                    'bower_components/ngImgCrop/compile/minified/ng-img-crop.js',
                    'bower_components/toastr/toastr.js',
                    'app/app.js',
                    'app/config.js',
                    'app/routes.js',
                    'app/controllers/home-controller.js',
                    'app/controllers/post-controller.js',
                    'app/controllers/login-controller.js'
                ],
                dest: 'dist/assets/js/scripts-1.0.0.min.js'
            }
        },
        copy: {
            main: {
                files: [{
                    expand: true,
                    cwd: 'bower_components/font-awesome/fonts',
                    src: '**',
                    dest: 'dist/assets/font',
                    flatten: false,
                }],
                files: [{
                    expand: true,
                    cwd: 'dev/assets/images',
                    src: '**',
                    dest: 'dist/assets/images',
                    flatten: false,
                }]
            }
        },
        htmlmin: {
            dist: {
                options: {
                    removeComments: true,
                    collapseWhitespace: true
                },
                files: {
                    'dist/pages/shared/header.html': 'dev/pages/shared/header.html',
                    'dist/pages/home.html': 'dev/pages/home.html',
                    'dist/pages/login.html': 'dev/pages/login.html',
                    'dist/pages/post.html': 'dev/pages/post.html',
                }
            }
        }
    });

    grunt.registerTask("dist", [
        'cssmin',
        'uglify',
        'copy',
        'htmlmin'
    ]);

    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-htmlmin');
};