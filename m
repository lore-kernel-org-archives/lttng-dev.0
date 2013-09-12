From: Christian Babeux <christian.babeux-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] Enable ptest support for lttng.
Date: Thu, 12 Sep 2013 18:12:37 -0400
Message-ID: <CAGDH53myHLkfCS51wXj6jV+cXLF1=2NqsHD86Wv6ovjRbtJuOA@mail.gmail.com>
References: <1378948190-16620-1-git-send-email-stefan_seefeld@mentor.com>
	<1378948190-16620-2-git-send-email-stefan_seefeld@mentor.com>
	<CAGDH53kUE8aB_MoRvsxhA7jhvTpvT0+DYCGNmZnVdMFLgreR7w@mail.gmail.com>
	<52320655.3080103@seefeld.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <52320655.3080103-v8iY73tHINja5EbDDlwbIw@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Stefan Seefeld <stefan-v8iY73tHINja5EbDDlwbIw@public.gmane.org>
Cc: "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
List-Id: lttng-dev@lists.lttng.org

> Still, I think it's good to include these tests. If anything they may
> just provide more motivation to address the underlying issue. :-)

Absolutely! I'll start a thread on lttng-dev to see how we can deal
with the current testsuite limitations.

>>> ++prove --merge -v --exec '' - < $1 | sed \
>>> ++  -e 's|^ok \(.*\)|PASS: \1|' \
>>> ++  -e 's|^not ok \(.*\)|FAIL: \1|' \
>>> ++  | egrep -h 'PASS|FAIL'
>> This is sadly needed because we are using TAP as our standardized test
>> output format across the multiples lttng codebases.
>
> Do you think it would be worthwhile submitting this patch upstream ?

This is pretty much OpenEmbedded specific and I don't think it is of
much use outside of ptest support.

> (The output format of prove is not the easiest to understand, and even
> with the above some information may be lost. A more robust fix would
> probably include a dedicated TAP formatter plugin
> (http://perldoc.perl.org/TAP/Formatter/Console.html) that produces
> ptest-compatible output.

Yes that would be a cleaner way of dealing with it. We would only need
to feed the appropriate 'testlist' file to this script and get proper
conversion of TAP to Automake-style test output. I'm wondering if such
a script would be useful for other projects/recipes using TAP tests
within oe/yocto?

Thanks,

Christian Babeux
EfficiOS Inc.
http://www.efficios.com
