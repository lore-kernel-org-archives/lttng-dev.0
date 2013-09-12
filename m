From: Stefan Seefeld <stefan@seefeld.name>
Subject: Re: Running lttng-tools testsuite against an installed
 codebase
Date: Thu, 12 Sep 2013 18:40:21 -0400
Message-ID: <523242D5.2000002__7522.45074040747$1379025678$gmane$org@seefeld.name>
References: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VKFYr-0004jZ-BC
	for lttng-dev@lists.lttng.org; Thu, 12 Sep 2013 18:40:33 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so440128obc.39
	for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2013 15:40:23 -0700 (PDT)
In-Reply-To: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
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

On 09/12/2013 06:29 PM, Christian Babeux wrote:
> Hi lttng-testers,
>
> The current lttng-tools testsuite has some limitations as recently
> pointed out on this OpenEmbedded thread [1].
>
> The testsuite cannot be runned against an installed codebase of
> lttng-tools because the tests assume that the lttng cli and the
> testapps are located in the build directory.
>
> Perhaps an env. var. could be used when running the make installcheck target?
>
> Any thoughts on how we could resolve this issue?

The only difference between 'check' and 'installcheck' should be the
location of the tested binaries, which should already be located
properly if PATH is set. If there is anything else that needs to be set
up first (such as some test input data or a temporary directory
structure) that should be done explicitly in a prerequisite makefile target.

I would avoid any obscure mechanism such as environment variables to
distinguish the two use-cases.

    Stefan

-- 

      ...ich hab' noch einen Koffer in Berlin...
