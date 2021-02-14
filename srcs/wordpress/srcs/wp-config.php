<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'diana' );

/** MySQL database password */
define( 'DB_PASSWORD', 'pajarito' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '/?YK.:x#L<5Zw96;-KjyP+b->-@}|miXH7pNZhr,,iw-<l-NK{|JQek7M]nC?Fs&');
define('SECURE_AUTH_KEY',  '=npUW`A=d+853J&L&E|fBx+P)Q.Ej6:Z#%7P-dE-2v=0@Ezhcm)@8IkvXE-Z<~y%');
define('LOGGED_IN_KEY',    'O?5TOfxaIWO*5Hlo0y&L#vc.C774tlsI`{^+{k/OO7zbgVodY+?|fkEt !yuF[g+');
define('NONCE_KEY',        'xBUuX-/J9>|s#f1KO2+[T<sV$0J&)tB|c5JGk0WSSxdSx]a6-6>Hhd)E-aAw.{fE');
define('AUTH_SALT',        'h;~AyOJ+9(p]F9/n]=xV|E$yK-{GXu|1Ka&!Qh~91Z$bHc]1/MfN`@X[uC6R7$jc');
define('SECURE_AUTH_SALT', ')-l([A[vN+9H#]D8US3#!Vqc,r=R(+]Zg|pkCL((Go|a#^TB=sKn_9vPp3Y5)=f$');
define('LOGGED_IN_SALT',   '>Ral1bZ37([*<85:25)]?+gdQx+D^o6nB?:Du3[T#CjGJ1JZX,5QJy_{ycXXkk#K');
define('NONCE_SALT',       '7SwH>+LdG(_xd7Z-{-z^m_t-U<m*T>qH%[#t-B(RyOsIC3K~)-)H+Y$`YWb_.Lm*');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';