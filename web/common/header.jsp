<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap-select -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">

<!-- JQuery -->
<script src='https://code.jquery.com/jquery-3.5.1.js'></script>

<!-- Fontawesome css
<link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
    href="/css/app-wa-02670e9412103b5852dcbe140d278c49.css?vsn=d"> -->
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

<!-- Validation functions -->
<script>
    function isNotEmpty(str) {
        return { result: str.replace(/\s+/g, '').length != 0, 
            message: 'This field must not be empty' 
        };
    }

    function isNotContainSpace(str) {
        return { result: str.search(" ") == -1, 
            message: 'Must not contain spaces' 
        };
    }

    function isNotContainSpecials(str) {
        const format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
        return { result: !format.test(str), 
            message: 'Must not contain any special characters' 
        };
    }

    function isValidEmail(email) {
        const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return { result: emailRegex.test(email), 
            message: 'Please enter a valid email'
        };
    }

    function isLengthEnough(str) {
        return { result: str.length >= 3, 
            message: 'Must be more than 3 characters'
        };
    }

    function isLengthPastEnough(str) {
        return { result: str.length <= 5, 
            message: 'Must be less than 5 characters'
        };
    }

    function isStartsWithChar(str) {
        return { result: /^[a-zA-Z]/.test(str[0]), 
            message: 'Must start with a character' 
        };
    }

    function addIsInvalid(input) {
        input.addClass("is-invalid");
    }

    function removeIsInvalid(input) {
        input.removeClass("is-invalid");
    }

    function setFeedback(message, feedback) {
        if (message) {
            feedback.text(message);
            feedback.show();
        } else {
            feedback.hide();
        }
    }

    function validate(input, feedback, ...checks) {
        const inputVal = input.val();
        let isValid = true;
        let validationMessage = '';

        for (let i = 0; i < checks.length; i++) {
            const checkResult = checks[i](inputVal);
            if (!checkResult.result) {
                isValid = false;
                if (checkResult.message) {
                    validationMessage = checkResult.message;
                }
                break;
            }
        }

        if (isValid) {
            setFeedback('', feedback);
            removeIsInvalid(input);
        } else {
            addIsInvalid(input);
            setFeedback(validationMessage, feedback);
        }

        return isValid;
    }

</script>
