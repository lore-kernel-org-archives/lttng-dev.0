From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools 4/6] Tests: Use Perl prove as
 the testsuite runner
Date: Thu, 21 Mar 2013 17:12:21 -0400
Message-ID: <CAGDH53nch9AjJP5Y--a=FPWCsCdfWJ0VaPZXAHRBgYcnzL3LjQ__18019.4392371506$1363900394$gmane$org@mail.gmail.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
	<1363895807-17892-4-git-send-email-christian.babeux@efficios.com>
	<514B746C.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UImmh-0007NE-MU
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 17:12:27 -0400
Received: by mail-vc0-f180.google.com with SMTP id m17so2664028vca.39
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 14:12:22 -0700 (PDT)
In-Reply-To: <514B746C.7010205@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> This new dependency should be documented in the README file.

Since lttng-tools depends on Automake (which is a Perl script), would
that still be relevant to add?

Thanks,

Christian

On Thu, Mar 21, 2013 at 4:58 PM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> On 2013-03-21 15:56, Christian Babeux wrote:
>> Currently the regression and unit testsuites are runned via a custom
>> runner script. By using the Perl prove utility, we can run the testsuites
>> and also gain additionnal features such as: parallel jobs, separate testlists,
>> etc.
>>
>
> This new dependency should be documented in the README file.
>
> Yannick
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
