$(function() {
    // Use for loop to ensure synchronous behavior
    for (var i=0; i<window.hiddenFields.length; i++) {
        // Find and field containers
        // To ensure that labels and instructions are also hidden
        $('#' + window.hiddenFields[i]).hide();
    }

    // Fade body in after all fields have been hidden
    // Beautiful, right? 😉
    $('body').fadeIn();
});
