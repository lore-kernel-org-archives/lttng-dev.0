From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: [PATCH] Add a git version information in LTTng
 versions compiled from git sources
Date: Thu, 14 Mar 2013 00:34:24 -0400
Message-ID: <CAEzWAe+Q41BjiSf+6FQ00jg3qrC71ZbdanDpunqFdYFeWBeGxg__12406.4398617067$1363235718$gmane$org@mail.gmail.com>
References: <5140A719.6020003@gmail.com>
	<1363230220-11071-1-git-send-email-raphael.beamonte@gmail.com>
	<51414101.4080809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFzs6-0001ee-Hf
	for lttng-dev@lists.lttng.org; Thu, 14 Mar 2013 00:34:30 -0400
Received: by mail-ve0-f175.google.com with SMTP id cy12so1372219veb.6
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 21:34:25 -0700 (PDT)
In-Reply-To: <51414101.4080809@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> One thing I'm not sure about is that currently, the version.h needs to
> be versioned but perhaps should be in the .gitignore file to only save
> the "original" version file in the repository. There could be another
> solution if you think it's better : generating the version.h file with
> the bash script at first run. In this case, I think the version.sh shell
> script should perhaps be a better solution.

For that part, you should probably have a version.h.in or something
similar that is the template and the version.h that is generated.

A make dist should probably generate a version.h without the git
version information.
