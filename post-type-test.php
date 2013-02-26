<?php

// Test custom content type
function post_type_test() {
	register_post_type('test',
		array('label' => __('Test'),
		'public' => true,
		'show_ui' => true,
		'supports' => array( 'title', 'editor', 'excerpt', 'custom-fields', 'thumbnail' ),
	));
}
add_action('init', 'post_type_test');
