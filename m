From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: userspace-rcu-0.8.6 problems on MacOSX
Date: Thu, 12 Mar 2015 13:24:53 -0400
Message-ID: <5501CBE5.1020702__12674.0471846007$1426181191$gmane$org@voxpopuli.im>
References: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YW6r0-0004Mb-N7
 for lttng-dev@lists.lttng.org; Thu, 12 Mar 2015 13:25:09 -0400
In-Reply-To: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jim Reid <jim@rfc1035.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Technically, liburcu is not supported on Mac, but if we can easily make 
it work, why not try!

I tried compiling it on an OS X system (Yosemite, autoconf/automake 
installed from Homebrew), but got many errors like this one:

In file included from wfcqueue.c:26:

./urcu/static/wfcqueue.h:260:22: error: passing 'struct __cds_wfcq_head *' to parameter of incompatible type 'cds_wfcq_head_ptr_t'

         if (_cds_wfcq_empty(head, tail))

                             ^~~~

./urcu/static/wfcqueue.h:132:56: note: passing argument to parameter 'u_head' here

static inline bool _cds_wfcq_empty(cds_wfcq_head_ptr_t u_head,

                                                        ^

What steps did you use to make it compile?

Cheers,
Alexandre


On 2015-03-11 11:50 AM, Jim Reid wrote:
> Hi. There are some problems getting this to compile on MacOSX (10.9.5):
>
> 1) Many of the make regtest tests fail because the time command use command line arguments. eg:
>
> ...
> ./test_urcu_lgc 4 4 10 -d 2 -b 32768
> /usr/bin/time: illegal option -- a
> usage: time [-lp] command.
> ...
>
> 2) The generated Makefiles feed Linuxy linker arguments (-Wl,-rpath==) to the compiler.
> I kludged that by manually editing the Makefile(s) to just use -L././libs instead. Which would seem to be a better solution in general. YMMV.
>
> Could you please fix these for a future release? Thanks.
>
>
