<?php

// WPGEN_Token custom content type
function post_type_WPGEN_token() {
	register_post_type('WPGEN_token',
		array('label' => __('WPGEN_Token'),
		'public' => true,
		'show_ui' => true,
		'supports' => array( 'title', 'editor', 'excerpt', 'custom-fields', 'thumbnail' ),
	));
}
add_action('init', 'post_type_WPGEN_token');