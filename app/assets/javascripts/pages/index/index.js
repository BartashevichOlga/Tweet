$("#success-alert").fadeTo(2000, 500).slideUp(500, function(){
    $("#success-alert").slideUp(1000);
});

$(":file").filestyle({icon: false, placeholder: 'Upload image', buttonText: 'Choose...'})