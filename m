From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-tools] lttng cli: Accept
	human	readable sizes for --subbuf-size
Date: Sat, 6 Apr 2013 04:26:14 -0400
Message-ID: <20130406082614.GA25199__19660.4036413648$1365269831$gmane$org@Krystal>
References: <1365039047-22417-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UOOS0-0006Er-9J
	for lttng-dev@lists.lttng.org; Sat, 06 Apr 2013 04:26:16 -0400
Content-Disposition: inline
In-Reply-To: <1365039047-22417-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> --subbuf-size accepts sizes such as:
> 
> - 123 -> 123
> - 123k -> 123 * 1024
> - 123M -> 123 * 1024 * 1024
> - 123G -> 123 * 1024 * 1024 * 1024
> 
> It uses the new parse_human_size function, which could probably be used
> at other places, such as tracefile size.
> 
> I wanted to add some unit tests for parse_human_size, but the current
> test system does not make it easy. They will come later.

Please make sure the test system modifications are in place, and the
tests are present, before this patch gets merged.

As long as this patch is not submitted for inclusion, but rather for
comments, please use [RFC PATCH lttng-tools] tag, to make it clear that
it is not submitted for merge in its current state.

More comments below,

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  src/bin/lttng/commands/enable_channels.c |   21 ++++-
>  src/bin/lttng/utils.c                    |  129 +++++++++++++++++++++++++++++-
>  src/bin/lttng/utils.h                    |    6 ++
>  3 files changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> index d026af4..c2e9c89 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -66,7 +66,7 @@ static struct poptOption long_options[] = {
>  	{"userspace",      'u', POPT_ARG_NONE, 0, OPT_USERSPACE, 0, 0},
>  	{"discard",        0,   POPT_ARG_NONE, 0, OPT_DISCARD, 0, 0},
>  	{"overwrite",      0,   POPT_ARG_NONE, 0, OPT_OVERWRITE, 0, 0},
> -	{"subbuf-size",    0,   POPT_ARG_DOUBLE, 0, OPT_SUBBUF_SIZE, 0, 0},
> +	{"subbuf-size",    0,   POPT_ARG_STRING, 0, OPT_SUBBUF_SIZE, 0, 0},
>  	{"num-subbuf",     0,   POPT_ARG_INT, 0, OPT_NUM_SUBBUF, 0, 0},
>  	{"switch-timer",   0,   POPT_ARG_INT, 0, OPT_SWITCH_TIMER, 0, 0},
>  	{"read-timer",     0,   POPT_ARG_INT, 0, OPT_READ_TIMER, 0, 0},
> @@ -289,6 +289,7 @@ int cmd_enable_channels(int argc, const char **argv)
>  	int opt, ret = CMD_SUCCESS;
>  	static poptContext pc;
>  	char *session_name = NULL;
> +	char *opt_arg = NULL;
>  
>  	init_channel_config();
>  
> @@ -309,8 +310,22 @@ int cmd_enable_channels(int argc, const char **argv)
>  			DBG("Channel set to overwrite");
>  			break;
>  		case OPT_SUBBUF_SIZE:
> -			/* TODO Replace atol with strtol and check for errors */
> -			chan.attr.subbuf_size = atol(poptGetOptArg(pc));
> +			/* Parse the size */
> +			opt_arg = poptGetOptArg(pc);
> +			if (!parse_human_size(opt_arg, &chan.attr.subbuf_size)) {

parse_human_size() -> parse_size_suffix()   ?

> +				ERR("Wrong value the --subbuf-size parameter: %s", opt_arg);
> +				ret = CMD_ERROR;
> +				goto end;
> +			}
> +
> +			/* Check if power of 2 */
> +			if ((chan.attr.subbuf_size - 1) & chan.attr.subbuf_size) {
> +				ERR("The subbuf size is not a power of 2: %" PRIu64 " (%s)",
> +						chan.attr.subbuf_size, opt_arg);
> +				ret = CMD_ERROR;
> +				goto end;
> +			}
> +
>  			DBG("Channel subbuf size set to %" PRIu64, chan.attr.subbuf_size);
>  			break;
>  		case OPT_NUM_SUBBUF:
> diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
> index b7f5170..d17fa9c 100644
> --- a/src/bin/lttng/utils.c
> +++ b/src/bin/lttng/utils.c
> @@ -16,9 +16,11 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <stdlib.h>
> +#include <assert.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <regex.h>
> +#include <stdlib.h>

any reason why stdlib is moved here ?

>  
>  #include <common/error.h>
>  
> @@ -77,3 +79,128 @@ void list_cmd_options(FILE *ofp, struct poptOption *options)
>  		}
>  	}
>  }
> +
> +/**
> + * Prints the error message corresponding to a regex error code.
> + *
> + * @param errcode	The error code.
> + * @param regex		The regex object that produced the error code.
> + */

static void ...

> +void regex_print_error(int errcode, regex_t *regex)
> +{
> +	/* Get length of error message and allocate accordingly */
> +	size_t length = regerror(errcode, regex, NULL, 0);
> +	char *buffer = malloc(length);
> +
> +	if (buffer) {

we try to minimize indentation of code.

if (!buffer) {
        ERR("regex_print_error: malloc failed");
        return;
}

and then continue with the OK path.

> +		/* Get and print error message */
> +		regerror(errcode, regex, buffer, length);
> +		ERR("regex error: %s\n", buffer);
> +		free(buffer);
> +	} else {
> +		ERR("regex_print_error: malloc failed");
> +	}
> +}
> +
> +/**
> + * Parse a string that represents a size in human readable format. It
> + * support decimal integers suffixed by 'k', 'M' or 'G'.

supports

> + *
> + * The suffix multiply the integer by:
> + * 'k': 1024
> + * 'M': 1024 * 1024
> + * 'G': 1024 * 1024 * 1024
> + *
> + * @param str	The string to parse.
> + * @param size	Pointer to a size_t that will be filled with the
> + * 	  	resulting size.
> + *
> + * @return	1 on success, 0 on failure.

The rest of lttng-tools uses 0 for success, negative error code for
failure. Please follow this style.

> + */
> +int parse_human_size(char *str, uint64_t *size)
> +{
> +	regex_t regex;
> +	int ret;
> +	const int nmatch = 2;
> +	regmatch_t matches[nmatch];
> +
> +	if (!str)
> +		return 0;
> +
> +	/* Compile regex */
> +	ret = regcomp(&regex, "^[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
> +
> +	/* Check for regex error */
> +	if (ret != 0) {
> +		regex_print_error(ret, &regex);
> +
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	/* Match regex */
> +	ret = regexec(&regex, str, nmatch, matches, 0);
> +	if (ret == 0) {

please perform error checking here, and don't indent the entire OK path
afterward.

> +		/* There is a match ! */
> +		long long base_size;
> +		long multiplier = 1;

unsigned int shift = 0;

> +		errno = 0;
> +		base_size = strtoll(str, NULL, 10);

why long long, and why strtoll ? See strtoull((3).

> +
> +		/* Check result of conversion */
> +		if (errno == ERANGE) {
> +			ERR("parse_human_size: the value %s caused strtol to overflow. "
> +					"Please use a smaller numerical value.", str);

You should use PERROR() macro or something like this.

> +			ret = 0;
> +			goto end;
> +		} else if (errno == EINVAL) {
> +			ERR("parse_human_size: strtol failed (%s)", str);

You should use PERROR() macro or something like this.

> +			ret = 0;
> +			goto end;
> +		}

please print a PERROR even if a different errno is encountered, just in
case. The man pages are known to sometimes have an incomplete list of
error values.

> +
> +		/* We should be safe because of the regex */
> +		assert(base_size > 0);

with strtoull this assert won't be needed.

> +
> +		/* Check if there is a suffix */
> +		regmatch_t suffix_match = matches[1];
> +		if (suffix_match.rm_eo - suffix_match.rm_so > 0) {

A check like:

if (suffix_match.rm_eo - suffix_match.rm_so == 1) {

would make doubly sure that we're only matching one character, and would
seem more robust.

> +			switch (*(str + suffix_match.rm_so)) {
> +			case 'K':
> +			case 'k':
> +				multiplier = KIBI;

shift = KIBI_LOG2;

> +				break;
> +			case 'M':
> +				multiplier = MEBI;

shift = MEBI_LOG2;

> +				break;
> +			case 'G':
> +				multiplier = GIBI;

shift = GIBI_LOG2;

> +				break;
> +			default:
> +				ERR("parse_human_size: invalid suffix");
> +				ret = 0;
> +				goto end;
> +			}
> +		}
> +
> +		*size = base_size * multiplier;

*size = base_size << shift;

> +
> +		/* Check for overflow */
> +		if (*size / base_size != multiplier) {

Divisions are painful of a number of architectures (especially
embedded), and usually slow. Division and modulo should not be used
unless absolutely necessary. Here, moving from multiplication/division
to shift allow us to perform this check using a simple shift rather than
a division:

if ((*size >> shift) != base_size) {

> +			ERR("parse_human_size: oops, overflow detected.");
> +			ret = 0;
> +			goto end;
> +		}
> +
> +		ret = 1;
> +		goto end;
> +	} else {
> +		/* There is no match (or error) */
> +		ret = 0;
> +		goto end;
> +	}
> +
> +end:
> +	regfree(&regex);
> +	return ret;
> +}
> diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
> index 9f7bfcc..cb57b93 100644
> --- a/src/bin/lttng/utils.h
> +++ b/src/bin/lttng/utils.h
> @@ -19,8 +19,14 @@
>  #define _LTTNG_UTILS_H
>  
>  #include <popt.h>
> +#include <stdint.h>
> +
> +#define KIBI 1024
> +#define MEBI (1024 * 1024)
> +#define GIBI (1024 * 1024 * 1024)

#define KIBI_LOG2       10
#define MEBI_LOG2       20
#define GIBI_LOG2       30

Thanks,

Mathieu

>  
>  char *get_session_name(void);
>  void list_cmd_options(FILE *ofp, struct poptOption *options);
> +int parse_human_size(char *str, uint64_t *size);
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

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
