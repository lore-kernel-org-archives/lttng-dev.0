From: Stefan Seefeld <stefan-v8iY73tHINja5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] Enable ptest support for lttng.
Date: Thu, 12 Sep 2013 14:22:13 -0400
Message-ID: <52320655.3080103@seefeld.name>
References: <1378948190-16620-1-git-send-email-stefan_seefeld@mentor.com>
	<1378948190-16620-2-git-send-email-stefan_seefeld@mentor.com>
	<CAGDH53kUE8aB_MoRvsxhA7jhvTpvT0+DYCGNmZnVdMFLgreR7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <CAGDH53kUE8aB_MoRvsxhA7jhvTpvT0+DYCGNmZnVdMFLgreR7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Christian Babeux <christian.babeux-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Cc: lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org, Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
List-Id: lttng-dev@lists.lttng.org

On 2013-09-12 14:12, Christian Babeux wrote:
> Hi Stefan,
>
>> +
>> +make -C tests installcheck
>> +
> A majority of the tests will probably fail this way. As of now, most
> tests assumes that they are being runned in the build tree and expect
> binaries to be at specific paths. We will have to fix this upstream if
> you want to integrate our testsuite with ptest.

That's right, in my tests only the "unit_tests" suite ran without
issues. The "fast_regressions" suite had many more failures than when
run as part of the 'check' target. (See my mail to the lttng list for more.)

Still, I think it's good to include these tests. If anything they may
just provide more motivation to address the underlying issue. :-)
>> ++prove --merge -v --exec '' - < $1 | sed \
>> ++  -e 's|^ok \(.*\)|PASS: \1|' \
>> ++  -e 's|^not ok \(.*\)|FAIL: \1|' \
>> ++  | egrep -h 'PASS|FAIL'
> This is sadly needed because we are using TAP as our standardized test
> output format across the multiples lttng codebases.

Do you think it would be worthwhile submitting this patch upstream ?
(The output format of prove is not the easiest to understand, and even
with the above some information may be lost. A more robust fix would
probably include a dedicated TAP formatter plugin
(http://perldoc.perl.org/TAP/Formatter/Console.html) that produces
ptest-compatible output.

    Stefan

-- 

      ...ich hab' noch einen Koffer in Berlin...
