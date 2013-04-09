From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools v3] lttng cli: Accept
	human	readable sizes for --subbuf-size
Date: Tue, 9 Apr 2013 14:32:20 -0400
Message-ID: <20130409183220.GC14986__42177.2753507414$1365532376$gmane$org@Krystal>
References: <1365439209-27624-1-git-send-email-simon.marchi@polymtl.ca>
	<51644824.6000505@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UPdLF-0003PM-1y
	for lttng-dev@lists.lttng.org; Tue, 09 Apr 2013 14:32:25 -0400
Content-Disposition: inline
In-Reply-To: <51644824.6000505@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> I wonder if this "string parsing human readable size" should go in
> libcommon. I can *easily* see that code being used in sessiond and
> relayd if some bytes size options are used.
> 
> Basically, you could simply move that code in src/common/utils.c/.h
> 
> Comments below:
> 
> Simon Marchi:
> > --subbuf-size accepts sizes such as:
> > 
> > - 123 -> 123
> > - 123k -> 123 * 1024
> > - 123M -> 123 * 1024 * 1024
> > - 123G -> 123 * 1024 * 1024 * 1024
> > 
> > It uses the new parse_size_suffix function, which could probably be used
> > at other places, such as tracefile size.
> > 
> > Unit tests are included.
> > 
> > Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> > ---
> > New in v3:
> > * Changes following Mathieu Desnoyers' comments.
> >  - Function name parse_human_size -> parse_size_suffix
> >  - Replace division for bit shift, multipliers by log2
> >  - Coding style issues.
> >  - strtoll -> strtoull
> > * Unit tests (depends on fix of object names clash)
> > 
> >  src/bin/lttng/commands/enable_channels.c |   21 ++++-
> >  src/bin/lttng/utils.c                    |  123 +++++++++++++++++++++++++++++-
> >  src/bin/lttng/utils.h                    |    6 ++
> >  tests/unit/Makefile.am                   |   15 +++-
> >  tests/unit/test_parse_size_suffix.c      |   72 +++++++++++++++++
> >  5 files changed, 230 insertions(+), 7 deletions(-)
> >  create mode 100644 tests/unit/test_parse_size_suffix.c
> > 
> > diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> > index d026af4..dbec8ab 100644
> > --- a/src/bin/lttng/commands/enable_channels.c
> > +++ b/src/bin/lttng/commands/enable_channels.c
> > @@ -66,7 +66,7 @@ static struct poptOption long_options[] = {
> >  	{"userspace",      'u', POPT_ARG_NONE, 0, OPT_USERSPACE, 0, 0},
> >  	{"discard",        0,   POPT_ARG_NONE, 0, OPT_DISCARD, 0, 0},
> >  	{"overwrite",      0,   POPT_ARG_NONE, 0, OPT_OVERWRITE, 0, 0},
> > -	{"subbuf-size",    0,   POPT_ARG_DOUBLE, 0, OPT_SUBBUF_SIZE, 0, 0},
> > +	{"subbuf-size",    0,   POPT_ARG_STRING, 0, OPT_SUBBUF_SIZE, 0, 0},
> >  	{"num-subbuf",     0,   POPT_ARG_INT, 0, OPT_NUM_SUBBUF, 0, 0},
> >  	{"switch-timer",   0,   POPT_ARG_INT, 0, OPT_SWITCH_TIMER, 0, 0},
> >  	{"read-timer",     0,   POPT_ARG_INT, 0, OPT_READ_TIMER, 0, 0},
> > @@ -289,6 +289,7 @@ int cmd_enable_channels(int argc, const char **argv)
> >  	int opt, ret = CMD_SUCCESS;
> >  	static poptContext pc;
> >  	char *session_name = NULL;
> > +	char *opt_arg = NULL;
> >  
> >  	init_channel_config();
> >  
> > @@ -309,8 +310,22 @@ int cmd_enable_channels(int argc, const char **argv)
> >  			DBG("Channel set to overwrite");
> >  			break;
> >  		case OPT_SUBBUF_SIZE:
> > -			/* TODO Replace atol with strtol and check for errors */
> > -			chan.attr.subbuf_size = atol(poptGetOptArg(pc));
> > +			/* Parse the size */
> > +			opt_arg = poptGetOptArg(pc);
> > +			if (parse_size_suffix(opt_arg, &chan.attr.subbuf_size) < 0) {
> > +				ERR("Wrong value the --subbuf-size parameter: %s", opt_arg);
> > +				ret = CMD_ERROR;
> > +				goto end;
> > +			}
> > +
> > +			/* Check if power of 2 */
> > +			if ((chan.attr.subbuf_size - 1) & chan.attr.subbuf_size) {
> > +				ERR("The subbuf size is not a power of 2: %" PRIu64 " (%s)",
> > +						chan.attr.subbuf_size, opt_arg);
> > +				ret = CMD_ERROR;
> > +				goto end;
> > +			}
> > +
> >  			DBG("Channel subbuf size set to %" PRIu64, chan.attr.subbuf_size);
> >  			break;
> >  		case OPT_NUM_SUBBUF:
> > diff --git a/src/bin/lttng/utils.c b/src/bin/lttng/utils.c
> > index b7f5170..cade12f 100644
> > --- a/src/bin/lttng/utils.c
> > +++ b/src/bin/lttng/utils.c
> > @@ -16,9 +16,11 @@
> >   */
> >  
> >  #define _GNU_SOURCE
> > -#include <stdlib.h>
> > +#include <assert.h>
> >  #include <ctype.h>
> >  #include <limits.h>
> > +#include <regex.h>
> > +#include <stdlib.h>
> >  
> >  #include <common/error.h>
> >  
> > @@ -77,3 +79,122 @@ void list_cmd_options(FILE *ofp, struct poptOption *options)
> >  		}
> >  	}
> >  }
> > +
> > +/**
> > + * Prints the error message corresponding to a regex error code.
> > + *
> > + * @param errcode	The error code.
> > + * @param regex		The regex object that produced the error code.
> > + */
> > +static void regex_print_error(int errcode, regex_t *regex)
> > +{
> > +	/* Get length of error message and allocate accordingly */
> > +	size_t length = regerror(errcode, regex, NULL, 0);
> > +	char *buffer = malloc(length);
> 
> I know it's not _necessary_ but I would prefer to have the same std
> across the code. So, we usually declare the variables without
> assignation (that comes from a function call), then use assert() for
> given params (if needed) and finally used them.
> 
> Here, declare length and buffer without assignation. Assert on "regex !=
> NULL" because a NULL value seems to me that it might break (or
> segfault). Finally, set length, check the return error code and set
> buffer checking also for errors.
> 
> Use zmalloc also please.
> 
> > +
> > +	if (!buffer) {
> > +		ERR("regex_print_error: malloc failed");
> > +		return;
> > +	}
> > +
> > +	/* Get and print error message */
> > +	regerror(errcode, regex, buffer, length);
> > +	ERR("regex error: %s\n", buffer);
> > +	free(buffer);
> > +
> > +}
> > +
> > +/**
> > + * Parse a string that represents a size in human readable format. It
> > + * supports decimal integers suffixed by 'k', 'M' or 'G'.
> > + *
> > + * The suffix multiply the integer by:
> > + * 'k': 1024
> > + * 'M': 1024 * 1024
> > + * 'G': 1024 * 1024 * 1024
> > + *
> > + * @param str	The string to parse.
> > + * @param size	Pointer to a size_t that will be filled with the
> > + * 	  	resulting size.
> > + *
> > + * @return	0 on success, -1 on failure.
> 
> No tabs is needed here after "return".
> 
> > + */
> > +int parse_size_suffix(char *str, uint64_t *size)
> > +{
> > +	regex_t regex;
> > +	int ret;
> > +	const int nmatch = 2;
> > +	regmatch_t matches[nmatch];
> > +
> > +	if (!str)
> > +		return 0;
> 
> *Always* {} around if/else statement. I know... the check patch script
> is not detecting it right but the CodingStyle mentions it.
> 
> > +
> > +	/* Compile regex */
> > +	ret = regcomp(&regex, "^[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
> > +
> > +	/* Check for regex error */
> > +	if (ret != 0) {
> > +		regex_print_error(ret, &regex);
> > +
> 
> Useless space.
> 
> > +		ret = -1;
> > +		goto end;
> > +	}
> > +
> > +	/* Match regex */
> > +	ret = regexec(&regex, str, nmatch, matches, 0);
> > +	if (ret != 0) {
> > +		/* There is no match (or error) */
> > +		ret = -1;
> > +		goto end;
> > +	}
> > +
> > +	/* There is a match ! */
> > +	unsigned long long base_size;
> > +	long shift = 0;
> > +	errno = 0;
> 
> Why is errno set to 0 ?

see strtoull(3).
> 
> > +	base_size = strtoll(str, NULL, 10);
> 
> I think you want "strtoUll" here.
> 
> > +
> 
> No space.
> 
> > +	/* Check result of conversion */
> > +	if (errno != 0) {
> 
> You should check base_size == ULLONG_MAX which is the return value of an
> overflow meaning an error instead of errno.

wrong, see strtoull(3).
> 
> > +		PERROR("strtoull");
> > +		ret = -1;
> > +		goto end;
> > +	}
> > +
> > +	/* Check if there is a suffix */
> > +	regmatch_t suffix_match = matches[1];
> 
> Declare first then assign. You can do this is suffix_match was used in a
> smaller scope (inside a if block for instance).
> 
> > +	if (suffix_match.rm_eo - suffix_match.rm_so == 1) {
> > +		switch (*(str + suffix_match.rm_so)) {
> > +		case 'K':
> > +		case 'k':
> > +			shift = KIBI_LOG2;
> 
> I wonder if these *_LOG2 should go in default.h ? Thoughts?

could. no strong feeling. Thanks,

Mathieu

> 
> > +			break;
> > +		case 'M':
> > +			shift = MEBI_LOG2;
> > +			break;
> > +		case 'G':
> > +			shift = GIBI_LOG2;
> > +			break;
> > +		default:
> > +			ERR("parse_human_size: invalid suffix");
> > +			ret = -1;
> > +			goto end;
> > +		}
> > +	}
> > +
> > +	*size = base_size << shift;
> > +
> > +	/* Check for overflow */
> > +	if ((*size >> shift) != base_size) {
> > +		ERR("parse_size_suffix: oops, overflow detected.");
> > +		ret = -1;
> > +		goto end;
> > +	}
> > +
> > +	ret = 0;
> > +	goto end;
> > +
> > +end:
> > +	regfree(&regex);
> 
> If regex was uninit like for instance on regcomp error, does this call
> behaves well ?
> 
> Thanks!
> David
> 
> > +	return ret;
> > +}
> > diff --git a/src/bin/lttng/utils.h b/src/bin/lttng/utils.h
> > index 9f7bfcc..12a72be 100644
> > --- a/src/bin/lttng/utils.h
> > +++ b/src/bin/lttng/utils.h
> > @@ -19,8 +19,14 @@
> >  #define _LTTNG_UTILS_H
> >  
> >  #include <popt.h>
> > +#include <stdint.h>
> > +
> > +#define KIBI_LOG2       10
> > +#define MEBI_LOG2       20
> > +#define GIBI_LOG2       30
> >  
> >  char *get_session_name(void);
> >  void list_cmd_options(FILE *ofp, struct poptOption *options);
> > +int parse_size_suffix(char *str, uint64_t *size);
> >  
> >  #endif /* _LTTNG_UTILS_H */
> > diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> > index 67e7fe4..5b49733 100644
> > --- a/tests/unit/Makefile.am
> > +++ b/tests/unit/Makefile.am
> > @@ -14,10 +14,11 @@ LIBCOMMON=$(top_builddir)/src/common/libcommon.la
> >  LIBSESSIOND_COMM=$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la
> >  LIBHASHTABLE=$(top_builddir)/src/common/hashtable/libhashtable.la
> >  
> > +# Define test programs
> > +noinst_PROGRAMS = test_uri test_session	test_kernel_data test_parse_size_suffix
> > +
> >  if HAVE_LIBLTTNG_UST_CTL
> > -noinst_PROGRAMS = test_uri test_session test_ust_data test_kernel_data
> > -else
> > -noinst_PROGRAMS = test_uri test_session	test_kernel_data
> > +noinst_PROGRAMS += test_ust_data
> >  endif
> >  
> >  # URI unit tests
> > @@ -69,3 +70,11 @@ test_kernel_data_SOURCES = test_kernel_data.c
> >  test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
> >  						 -lrt
> >  test_kernel_data_LDADD += $(KERN_DATA_TRACE)
> > +
> > +# parse_size_suffix unit test
> > +PARSE_SIZE_SUFFIX=$(top_srcdir)/src/bin/lttng/utils.o \
> > +		$(top_srcdir)/src/bin/lttng/conf.o
> > +
> > +test_parse_size_suffix_SOURCES = test_parse_size_suffix.c
> > +test_parse_size_suffix_LDADD = $(LIBTAP)
> > +test_parse_size_suffix_LDADD += $(PARSE_SIZE_SUFFIX)
> > diff --git a/tests/unit/test_parse_size_suffix.c b/tests/unit/test_parse_size_suffix.c
> > new file mode 100644
> > index 0000000..70ccb76
> > --- /dev/null
> > +++ b/tests/unit/test_parse_size_suffix.c
> > @@ -0,0 +1,72 @@
> > +/*
> > + * Copyright (C) - 2013 Simon Marchi <simon.marchi@polymtl.ca>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by as
> > + * published by the Free Software Foundation; only version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program; if not, write to the Free Software Foundation, Inc., 51
> > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#include <assert.h>
> > +#include <string.h>
> > +
> > +#include <tap/tap.h>
> > +
> > +#include <src/bin/lttng/utils.h>
> > +
> > +/* For lttngerr.h */
> > +int lttng_opt_quiet = 1;
> > +int lttng_opt_verbose = 3;
> > +
> > +/* Valid test cases */
> > +static char *valid_tests_inputs[] = { "0", "1234", "16k", "128K", "32M", "1024G" };
> > +static uint64_t valid_tests_expected_results[] = {0, 1234, 16384, 131072, 33554432, 1099511627776};
> > +static const int num_valid_tests = sizeof(valid_tests_inputs) / sizeof(valid_tests_inputs[0]);
> > +
> > +/* Invalid test cases */
> > +static char *invalid_tests_inputs[] = { "", "-1", "k", "4611686018427387904G" };
> > +static const int num_invalid_tests = sizeof(invalid_tests_inputs) / sizeof(invalid_tests_inputs[0]);
> > +
> > +void test_parse_size_suffix(void)
> > +{
> > +	uint64_t result;
> > +	int ret;
> > +	int i;
> > +
> > +	// Test valid cases
> > +	for (i = 0; i < num_valid_tests; i++) {
> > +		char name[100];
> > +		sprintf(name, "testing %s", valid_tests_inputs[i]);
> > +
> > +		ret = parse_size_suffix(valid_tests_inputs[i], &result);
> > +		ok(ret == 0 && result == valid_tests_expected_results[i], name);
> > +	}
> > +
> > +	// Test invalid cases
> > +	for (i = 0; i < num_invalid_tests; i++) {
> > +		char name[100];
> > +		sprintf(name, "testing %s", invalid_tests_inputs[i]);
> > +
> > +		ret = parse_size_suffix(invalid_tests_inputs[i], &result);
> > +		ok(ret != 0, name);
> > +	}
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	plan_tests(num_valid_tests + num_invalid_tests);
> > +
> > +	diag("parse_size_suffix tests");
> > +
> > +	test_parse_size_suffix();
> > +
> > +	return exit_status();
> > +}
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
