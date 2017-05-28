define(function (require, exports, module) {

    var Validator = require('bootstrap.validator');
    require('common/validator-rules').inject(Validator);
    

    exports.run = function () {
        /*var Humanitieseditor = CKEDITOR.replace('schools_campusHumanities', {
            toolbar: 'Simple',
            filebrowserImageUploadUrl: $('#schools_campusHumanities').data('imageUploadUrl')
        });

        var AmorousFeelingseditor = CKEDITOR.replace('schools_campusAmorousFeelings', {
            toolbar: 'Simple',
            filebrowserImageUploadUrl: $('#schools_campusAmorousFeelings').data('imageUploadUrl')
        });*/

        // $(".date").datetimepicker({
        //     autoclose: true,
        //     format: 'yyyy-mm-dd',
        //     minView: 'month'
        // });
        
        var validator = new Validator({
            element: '#add-wxstu-form',
            failSilently: true,
            onFormValidated: function(error){
                if (error) {
                    return false;
                }
                $('#wxstu-save-btn').button('submiting').addClass('disabled');
            }
        });

         validator.on('formValidate', function(elemetn, event) {
            /*Humanitieseditor.updateElement();
            AmorousFeelingseditor.updateElement();*/
        });

    };

});