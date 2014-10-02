/**
 * Created by papua on 2014/10/01.
 */

window.onload = function() {
    document.getElementsByClassName('preview-src')[0].addEventListener('change', updatePreview, false)
}

function updatePreview() {
    var reader = new FileReader();
    reader.onload = function (e) {
        document.getElementById('preview').setAttribute('src', e.target.result);
    };
    reader.readAsDataURL(this.files[0]);
}
