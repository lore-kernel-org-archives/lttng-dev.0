From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [PATCH lttng-tools 4/6] Tests: Use Perl prove as
 the testsuite runner
Date: Thu, 21 Mar 2013 17:25:47 -0400
Message-ID: <CAGDH53=eWqSre8+nXB2yznPz2+KzQHt2e8uhgHfOCZyct6Sp7Q__26051.229859195$1363901199$gmane$org@mail.gmail.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
	<1363895807-17892-4-git-send-email-christian.babeux@efficios.com>
	<514B746C.7010205@gmail.com>
	<CAGDH53nch9AjJP5Y--a=FPWCsCdfWJ0VaPZXAHRBgYcnzL3LjQ@mail.gmail.com>
	<514B79CF.2040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UImzg-0007UV-Kx
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 17:25:52 -0400
Received: by mail-vc0-f181.google.com with SMTP id hv10so2680165vcb.40
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 14:25:47 -0700 (PDT)
In-Reply-To: <514B79CF.2040807@gmail.com>
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

Okay I'll post a patch updating the README.

On Thu, Mar 21, 2013 at 5:21 PM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> On 2013-03-21 17:12, Christian Babeux wrote:
>>> This new dependency should be documented in the README file.
>> Since lttng-tools depends on Automake (which is a Perl script), would
>> that still be relevant to add?
>>
> Automake is not needed if you use the tar.gz, so I think it should be there
