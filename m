From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH lttng-tools 4/6] Tests: Use Perl prove as
 the testsuite runner
Date: Thu, 21 Mar 2013 16:58:20 -0400
Message-ID: <514B746C.7010205__49310.4236004457$1363899558$gmane$org@gmail.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
	<1363895807-17892-4-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UImZC-0007Ef-Ui
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 16:58:31 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so4078458ieb.15
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 13:58:25 -0700 (PDT)
In-Reply-To: <1363895807-17892-4-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-03-21 15:56, Christian Babeux wrote:
> Currently the regression and unit testsuites are runned via a custom
> runner script. By using the Perl prove utility, we can run the testsuites
> and also gain additionnal features such as: parallel jobs, separate testlists,
> etc.
>

This new dependency should be documented in the README file.

Yannick
