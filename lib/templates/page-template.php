<?php
/*
Template Name: WPGEN_Token
*/
?>
<?php get_header(); ?>

	<?php if (have_posts()) : while (have_posts()) : the_post(); ?>

		<?php the_title(); ?>

		<?php the_post_thumbnail(); ?>

		<?php the_content(); ?>

	<?php endwhile; endif; ?>

<?php get_footer(); ?>