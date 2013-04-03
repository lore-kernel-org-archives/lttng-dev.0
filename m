From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Tue, 2 Apr 2013 22:39:47 -0400
Message-ID: <CAGDH53ks4zAi7YfQZfFA1d3r=2ZEUvX9_gZYUk9YyPZHwT6uuA__38155.1000442871$1364956847$gmane$org@mail.gmail.com>
References: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UNDc9-00030C-LR
	for lttng-dev@lists.lttng.org; Tue, 02 Apr 2013 22:39:53 -0400
Received: by mail-vb0-f52.google.com with SMTP id w8so112340vbf.11
	for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2013 19:39:48 -0700 (PDT)
In-Reply-To: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
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

> I wanted to add some unit tests for parse_human_size, but the current
> test system does not make it easy. They will come later.

Could you describe the issues you had on a separate thread so we can
further discuss it?

Here a few comments on your patch:

> +       char *buffer = malloc(length);
> +
> +       if (buffer) {
> +               /* Get and print error message */
> +               regerror(errcode, regex, buffer, length);
> +               ERR("%s\n", buffer);
> +               free(buffer);
> +       }

What if malloc() fails? Printing an error message would be appropriate
to handle that case.

> +       /* Compile regex */
> +       ret = regcomp(&regex, "^[0-9][0-9]*\\([kmg]\\{0,1\\}\\)$", REG_ICASE);

This regex could be simplified to: "^[:digit:]+\\([kmg]\\)?$"

> +               *size = atol(str);

atol() can return negative numbers and the result is stored in an
unsigned (size_t). This could lead to enormous subbuffers allocated by
accident. A check should be added to allow only positive numbers.

Also, atol() does not detect conversion errors, returning 0 in error
cases [1]. Perhaps using strtol() would be more appropriate?

> +               /* Check if there is a suffix */
> +               regmatch_t suffix_match = matches[1];
> +               if (suffix_match.rm_eo - suffix_match.rm_so > 0) {
> +                       switch (*(str + suffix_match.rm_so)) {
> +                       case 'k':
> +                       case 'K':
> +                               *size = *size * 1024;
> +                               break;
> +                       case 'm':
> +                       case 'M':
> +                               *size = *size * 1024 * 1024;
> +                               break;
> +                       case 'g':
> +                       case 'G':
> +                               *size = *size * 1024 * 1024 * 1024;
> +                               break;
> +                       }

I think you could split the computation of the human size in two
separate variables (size, computed_size perhaps?).

Also, you could add checks for possible overflows/truncation in the
computation/store  (e.g. a user could specify 4194304K (SIZE_MAX/1024
+ 1), quite unlikely but still possible!). This might be a bit
overkill though...

Could you also add a default case with perhaps ERR() or assert()?

> +               ret = 1;
> [...]
> +               regfree(&regex);
> +               return 1;

ret seems to be unused here. Maybe you meant return ret?

You might also want to add negative numbers and large number testcases
to your unit tests.

Looking forward to the corrected patch + unit tests :).

Thanks!

Christian

P.S.: This new feature seems in part related to bug #228 [1].

[1] - http://stackoverflow.com/questions/3792663/atol-v-s-strtol
[2] - http://bugs.lttng.org/issues/228

On Tue, Apr 2, 2013 at 4:45 PM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
>
> --subbuf-size accepts sizes such as:
>
> - 123 -> 123
> - 123k or 123K -> 123 * 1024
> - 123m or 123M -> 123 * 1024 * 1024
> - 123g or 123G -> 123 * 1024 * 1024 * 1024
>
> It uses the new parse_human_size function, which could probably be used
> at other places, such as tracefile size.
>
> I wanted to add some unit tests for parse_human_size, but the current
> test system does not make it easy. They will come later.
>
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  src/bin/lttng/commands/enable_channels.c |   18 +++++-
>  src/bin/lttng/utils.c                    |   96 +++++++++++++++++++++++++++++-
>  src/bin/lttng/utils.h                    |    2 +
>  3 files changed, 113 insertions(+), 3 deletions(-)
>
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> index d026af4..f71bda5 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -289,6 +289,7 @@ int cmd_enable_channels(int argc, const char **argv)
>         int opt, ret = CMD_SUCCESS;
>         static poptContext pc;
>         char *session_name = NULL;
> +       char *opt_arg = NULL;
>
>         init_channel_config();
>
> @@ -309,8 +310,21 @@ int cmd_enable_channels(int argc, const char **argv)
>                         DBG("Channel set to overwrite");
>                         break;
>                 case OPT_SUBBUF_SIZE:
> -                       /* TODO Replace atol with strtol and check for errors */
> -                       chan.attr.subbuf_size = atol(poptGetOptArg(pc));
> +                       /* Parse the size */
> +                       opt_arg = poptGetOptArg(pc);
> +                       if (!parse_human_size(opt_arg, &chan.attr.subbuf_size)) {
> +                               ERR("Wrong format for subbuf size parameter: %s", opt_arg);
> +                               ret = CMD_ERROR;
> +                               goto end;
> +                       }
> +
> +                       /* Check if power of 2 */
> +                       if ((chan.attr.subbuf_size - 1) & chan.attr.subbuf_size) {
> +                               ERR("The subbuf size is not a power of 2: %" PRIu64 " (%s)", chan.attr.subbuf_size, opt_arg);
> +                               ret = CMD_ERROR;
> +                               goto end;
> +                       }
> +
>                         DBG("Channel subbuf size set to %" PRIu64, chan.attr.subbuf_size);
>                         break;
>                 case OPT_NUM_SUBBUF:
> diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
> index b7f5170..a21f00f 100644
> --- a/src/bin/lttng/utils.c
> +++ b/src/bin/lttng/utils.c
> @@ -16,9 +16,10 @@
>   */
>
>  #define _GNU_SOURCE
> -#include <stdlib.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <regex.h>
> +#include <stdlib.h>
>
>  #include <common/error.h>
>
> @@ -77,3 +78,96 @@ void list_cmd_options(FILE *ofp, struct poptOption *options)
>                 }
>         }
>  }
> +
> +/**
> + * Prints the error message corresponding to a regex error code.
> + *
> + * @param errcode      The error code.
> + * @param regex                The regex object that produced the error code.
> + */
> +void regex_print_error(int errcode, regex_t *regex)
> +{
> +       /* Get length of error message and allocate accordingly */
> +       size_t length = regerror(errcode, regex, NULL, 0);
> +       char *buffer = malloc(length);
> +
> +       if (buffer) {
> +               /* Get and print error message */
> +               regerror(errcode, regex, buffer, length);
> +               ERR("%s\n", buffer);
> +               free(buffer);
> +       }
> +}
> +
> +/**
> + * Parse a string that represents a size in human readable format. It
> + * support decimal integers suffixed by 'k', 'K', 'm', 'M', g' or 'G'.
> + *
> + * The suffix multiply the integer by:
> + * 'k' or 'K': 1024
> + * 'm' or 'M': 1024 * 1024
> + * 'g' or 'G': 1024 * 1024 * 1024
> + *
> + * @param str  The string to parse.
> + * @param size Pointer to a size_t that will be filled with the
> + *             resulting size.
> + *
> + * @return     1 on success, 0 on failure.
> + */
> +uint64_t parse_human_size(char *str, size_t *size)
> +{
> +       regex_t regex;
> +       int ret;
> +
> +       if (!str)
> +               return 0;
> +
> +       /* Compile regex */
> +       ret = regcomp(&regex, "^[0-9][0-9]*\\([kmg]\\{0,1\\}\\)$", REG_ICASE);
> +
> +       /* Check for regex error */
> +       if (ret != 0) {
> +               regex_print_error(ret, &regex);
> +
> +               regfree(&regex);
> +               return 0;
> +       }
> +
> +       const int nmatch = 2;
> +       regmatch_t matches[nmatch];
> +
> +       /* Match regex */
> +       ret = regexec(&regex, str, nmatch, matches, 0);
> +       if (ret == 0) {
> +               /* There is a match ! */
> +               ret = 1;
> +
> +               *size = atol(str);
> +
> +               /* Check if there is a suffix */
> +               regmatch_t suffix_match = matches[1];
> +               if (suffix_match.rm_eo - suffix_match.rm_so > 0) {
> +                       switch (*(str + suffix_match.rm_so)) {
> +                       case 'k':
> +                       case 'K':
> +                               *size = *size * 1024;
> +                               break;
> +                       case 'm':
> +                       case 'M':
> +                               *size = *size * 1024 * 1024;
> +                               break;
> +                       case 'g':
> +                       case 'G':
> +                               *size = *size * 1024 * 1024 * 1024;
> +                               break;
> +                       }
> +               }
> +
> +               regfree(&regex);
> +               return 1;
> +       } else {
> +               /* There is no match (or error) */
> +               regfree(&regex);
> +               return 0;
> +       }
> +}
> diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
> index 9f7bfcc..20ebd68 100644
> --- a/src/bin/lttng/utils.h
> +++ b/src/bin/lttng/utils.h
> @@ -19,8 +19,10 @@
>  #define _LTTNG_UTILS_H
>
>  #include <popt.h>
> +#include <stdint.h>
>
>  char *get_session_name(void);
>  void list_cmd_options(FILE *ofp, struct poptOption *options);
> +uint64_t parse_human_size(char *str, size_t *size);
>
>  #endif /* _LTTNG_UTILS_H */
> --
> 1.7.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
