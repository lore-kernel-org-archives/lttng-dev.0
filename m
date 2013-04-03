From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Wed, 3 Apr 2013 12:39:17 -0400
Message-ID: <CAGDH53mHs7Sk_WXEFi=tXi42Kmjcy9LKNJ0Zn50CU14ZX5+eAg__40994.0732330599$1365007220$gmane$org@mail.gmail.com>
References: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
	<CAGDH53ks4zAi7YfQZfFA1d3r=2ZEUvX9_gZYUk9YyPZHwT6uuA@mail.gmail.com>
	<CAFXXi0=GHXVvAmx7DZ44rSQ2SK6cXUjDhOyA2PLBB2HG7kHjSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UNQiZ-0001ZL-CD
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 12:39:23 -0400
Received: by mail-vb0-f52.google.com with SMTP id w8so602006vbf.11
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 09:39:17 -0700 (PDT)
In-Reply-To: <CAFXXi0=GHXVvAmx7DZ44rSQ2SK6cXUjDhOyA2PLBB2HG7kHjSQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Simon,

> I preferred not to use extended regex. + and ? is included in the
> extended posix regexes [1]. I also prefer [0-9] over [:digit:],
> because it is as clear and less characters, but I don't mind :).

Alright, let's go with the one using basic POSIX regexes.

>> atol() can return negative numbers and the result is stored in an
>> unsigned (size_t). This could lead to enormous subbuffers allocated by
>> accident. A check should be added to allow only positive numbers.
>>
>> Also, atol() does not detect conversion errors, returning 0 in error
>> cases [1]. Perhaps using strtol() would be more appropriate?
>
> True. But here, we are safe because the regex test passed We know for
> sure that we have a positive number that atol will correctly parse.

Yes, indeed. Maybe adding an assert(*size > 0) could warn developers
to pay attention when eventually moving code around.

But the latter point is still unadressed: an error condition cannot be
distinguished from the value "0". I would recommend using strtol()
instead.

> Do you want to return both values to the caller, or simply use two
> intermediate variables and multiply them at the end ?

Use two intermediate variables in a similar fashion:
---

size_t user_size, computed_size;

[...]

user_size = atol(str);

[...]

switch (*(str + suffix_match.rm_so)) {
    case 'k':
    case 'K':
        computed_size = user_size * 1024;
        /* Maybe add overflow checks on computed_size here */
        ret = 1;

[...]

/* If no error occurred */
*size = computed_size;
return ret;

---

>> Also, you could add checks for possible overflows/truncation in the
>> computation/store  (e.g. a user could specify 4194304K (SIZE_MAX/1024
>> + 1), quite unlikely but still possible!). This might be a bit
>> overkill though...
>
> Do you have an idea in mind on ho to do this ?

You could probably detect the overflow of the multiplication with this:

if (user_size != 0 && computed_size / user_size != 1024) {
    /* Overflow, impendent doom, abort mission */
}

Here a couple more comments on the patch:

- Instead of hardcoding the constants 1024, 1024*1024, 1024*1024*1024,
etc. you could add some defines for them.

- Perhaps in a separate patch, the lttng(1) manpage should be updated
to reflect the new options added to the cli (e.g. --subbuf-size
SIZE[KMG])

Thanks!

Christian

On Tue, Apr 2, 2013 at 11:37 PM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> On 2 April 2013 22:39, Christian Babeux <christian.babeux@efficios.com> wrote:
>> Hi Simon,
>>
>>> I wanted to add some unit tests for parse_human_size, but the current
>>> test system does not make it easy. They will come later.
>>
>> Could you describe the issues you had on a separate thread so we can
>> further discuss it?
>
> Will do.
>
>> Here a few comments on your patch:
>>
>>> +       char *buffer = malloc(length);
>>> +
>>> +       if (buffer) {
>>> +               /* Get and print error message */
>>> +               regerror(errcode, regex, buffer, length);
>>> +               ERR("%s\n", buffer);
>>> +               free(buffer);
>>> +       }
>>
>> What if malloc() fails? Printing an error message would be appropriate
>> to handle that case.
>
> Ok.
>
>>> +       /* Compile regex */
>>> +       ret = regcomp(&regex, "^[0-9][0-9]*\\([kmg]\\{0,1\\}\\)$", REG_ICASE);
>>
>> This regex could be simplified to: "^[:digit:]+\\([kmg]\\)?$"
>
> I preferred not to use extended regex. + and ? is included in the
> extended posix regexes [1]. I also prefer [0-9] over [:digit:],
> because it is as clear and less characters, but I don't mind :).
>
>>> +               *size = atol(str);
>>
>> atol() can return negative numbers and the result is stored in an
>> unsigned (size_t). This could lead to enormous subbuffers allocated by
>> accident. A check should be added to allow only positive numbers.
>>
>> Also, atol() does not detect conversion errors, returning 0 in error
>> cases [1]. Perhaps using strtol() would be more appropriate?
>
> True. But here, we are safe because the regex test passed We know for
> sure that we have a positive number that atol will correctly parse.
>
>>> +               /* Check if there is a suffix */
>>> +               regmatch_t suffix_match = matches[1];
>>> +               if (suffix_match.rm_eo - suffix_match.rm_so > 0) {
>>> +                       switch (*(str + suffix_match.rm_so)) {
>>> +                       case 'k':
>>> +                       case 'K':
>>> +                               *size = *size * 1024;
>>> +                               break;
>>> +                       case 'm':
>>> +                       case 'M':
>>> +                               *size = *size * 1024 * 1024;
>>> +                               break;
>>> +                       case 'g':
>>> +                       case 'G':
>>> +                               *size = *size * 1024 * 1024 * 1024;
>>> +                               break;
>>> +                       }
>>
>> I think you could split the computation of the human size in two
>> separate variables (size, computed_size perhaps?).
>
> Do you want to return both values to the caller, or simply use two
> intermediate variables and multiply them at the end ?
>
>> Also, you could add checks for possible overflows/truncation in the
>> computation/store  (e.g. a user could specify 4194304K (SIZE_MAX/1024
>> + 1), quite unlikely but still possible!). This might be a bit
>> overkill though...
>
> Do you have an idea in mind on ho to do this ?
>
>> Could you also add a default case with perhaps ERR() or assert()?
>
> Like earlier, we are safe because we passed the regex test. But it's
> still good idea to add this default to catch eventual dev mistakes.
>
>>> +               ret = 1;
>>> [...]
>>> +               regfree(&regex);
>>> +               return 1;
>>
>> ret seems to be unused here. Maybe you meant return ret?
>
> Oops.
>
>> You might also want to add negative numbers and large number testcases
>> to your unit tests.
>
> Of course.
>
>> Looking forward to the corrected patch + unit tests :).
>>
>> Thanks!
>>
>> Christian
>>
>> P.S.: This new feature seems in part related to bug #228 [1].
>>
>> [1] - http://stackoverflow.com/questions/3792663/atol-v-s-strtol
>> [2] - http://bugs.lttng.org/issues/228
>
> Thanks for the comments.
>
> Simon
>
> [1] http://en.wikipedia.org/wiki/Regular_expression#POSIX_Basic_Regular_Expressions
