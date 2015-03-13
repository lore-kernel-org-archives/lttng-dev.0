From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: userspace-rcu-0.8.6 problems on MacOSX
Date: Fri, 13 Mar 2015 17:19:37 -0400
Message-ID: <55035469.9050001__6025.12141126699$1426281665$gmane$org@voxpopuli.im>
References: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>	<5501CBE5.1020702@voxpopuli.im>
 <CAJ7wx-EgDGitV7swToCZohrmept1pi+OkgBCeFXmkwS25GBP8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YWWzg-0004ft-23
 for lttng-dev@lists.lttng.org; Fri, 13 Mar 2015 17:19:48 -0400
In-Reply-To: <CAJ7wx-EgDGitV7swToCZohrmept1pi+OkgBCeFXmkwS25GBP8Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>, Jim Reid <jim@rfc1035.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 2015-03-13 4:59 AM, Zifei Tong wrote:
>
> [...]
> gcc 4.9 from Homebrew works fine. For clang I have to apply a patch to move
> '__attribute__((__transparent_union__))' after the union declaration.
> I think this
> might be a clang bug.

Indeed, I tested it with clang 3.5 on Linux and it gives the same error 
too. But your patch fixes it (and it keeps working fine with GCC), it 
seems Clang expects the __attribute__ to be after the closing brace. GCC 
accepts both, although they recommend the other way:

(from https://gcc.gnu.org/onlinedocs/gcc/Type-Attributes.html )
For an enum, struct or union type, you may specify attributes either 
between the enum, struct or union tag and the name of the type, or just 
past the closing curly brace of the /definition/. The former syntax is 
preferred.


I don't know what the liburcu maintainers prefer, to keep using GCC's 
recommended syntax, or to make it compilable on current Clang?

>
>
>
>>
>>
>> On 2015-03-11 11:50 AM, Jim Reid wrote:
>>> Hi. There are some problems getting this to compile on MacOSX (10.9.5):
>>>
>>> 1) Many of the make regtest tests fail because the time command use
>>> command line arguments. eg:
>>>
>>> ...
>>> ./test_urcu_lgc 4 4 10 -d 2 -b 32768
>>> /usr/bin/time: illegal option -- a
>>> usage: time [-lp] command.
>>> ...

I found the culprit, the scripts tests/benchmark/runtests.sh and 
runtests-batch.sh run "time" with -a -o options, with don't exist on 
OSX's implementation. Changing the script to instead use output 
redirection keeps more or less the same output:

diff --git a/tests/benchmark/runtests-batch.sh b/tests/benchmark/runtests-batch.sh

index 2da1401..3d295fb 100755

--- a/tests/benchmark/runtests-batch.sh

+++ b/tests/benchmark/runtests-batch.sh

@@ -6,7 +6,7 @@ log_file="runall.detail.log"

  

  # Check if time bin is non-empty

  if [ -n "$test_time_bin" ]; then

-       time_command="$test_time_bin -a -o $log_file"

+       time_command="$test_time_bin"

  else

         time_command=""

  fi

@@ -14,6 +14,6 @@ fi

  #for a in test_urcu_gc test_urcu_gc_mb test_urcu_qsbr_gc; do

  for a in test_urcu_gc; do

         echo "./${a} $*" | tee -a "$log_file"

-       $time_command ./${a} $*

+       $time_command ./${a} $* 2>> $log_file

  done



However, by doing so those tests now hang on my Mac test system (whereas 
before they would get skipped). Is it possible those tests don't even 
work on Mac?


>>>
>>> 2) The generated Makefiles feed Linuxy linker arguments (-Wl,-rpath==) to
>>> the compiler.
>>> I kludged that by manually editing the Makefile(s) to just use -L././libs
>>> instead. Which would seem to be a better solution in general. YMMV.
> Apparently, ld in OS X does not support -Wl,-rpath="/foo/bar" syntax,
> simply replace '='
> with space like -Wl,-rpath "/foo/bar" did the trick. I can send a
> patch for this.

Sure, you could send a patch. It keeps working with GNU's ld too, so I 
assume it would be acceptable.


Cheers,
Alexandre

>
> Thanks,
> Zifei Tong
>
>>> Could you please fix these for a future release? Thanks.
>>>
>>>
