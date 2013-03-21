From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH lttng-tools 4/6] Tests: Use Perl prove as
 the testsuite runner
Date: Thu, 21 Mar 2013 17:21:19 -0400
Message-ID: <514B79CF.2040807__24048.10797093$1363900934$gmane$org@gmail.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
	<1363895807-17892-4-git-send-email-christian.babeux@efficios.com>
	<514B746C.7010205@gmail.com>
	<CAGDH53nch9AjJP5Y--a=FPWCsCdfWJ0VaPZXAHRBgYcnzL3LjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UImvO-0007RT-7l
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 17:21:26 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so2899382iae.39
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 14:21:20 -0700 (PDT)
In-Reply-To: <CAGDH53nch9AjJP5Y--a=FPWCsCdfWJ0VaPZXAHRBgYcnzL3LjQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-03-21 17:12, Christian Babeux wrote:
>> This new dependency should be documented in the README file.
> Since lttng-tools depends on Automake (which is a Perl script), would
> that still be relevant to add?
>
Automake is not needed if you use the tar.gz, so I think it should be there
