From: Stefan Seefeld <stefan@seefeld.name>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation for
 some pthread functions.
Date: Wed, 31 Jul 2013 20:17:27 -0400
Message-ID: <51F9A917.9010509__16350.2080868513$1375316310$gmane$org@seefeld.name>
References: <51F97688.30704@mentor.com>
	<CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ye0-f171.google.com ([209.85.213.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1V4gaG-0001zC-IU
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 20:17:40 -0400
Received: by mail-ye0-f171.google.com with SMTP id l10so531627yen.30
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 17:17:31 -0700 (PDT)
Received: from [192.168.2.10] (bas2-montreal29-1279583707.dsl.bell.ca.
	[76.68.229.219])
	by mx.google.com with ESMTPSA id g66sm509477yhd.11.2013.07.31.17.17.27
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Wed, 31 Jul 2013 17:17:29 -0700 (PDT)
In-Reply-To: <CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA@mail.gmail.com>
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

On 07/31/2013 06:00 PM, J=E9r=E9mie Galarneau wrote:
> Hi Stefan,
>
> Please inline your patches in the future as it makes the review process s=
impler.
> There are a number of stylistic problems, mostly misplaced braces.
>
> You can run your patches through the checkpatch.pl script found in
> lttng-tools/extras. It will spot most coding-style related problems
> right away.

OK, will do, once the patch is approved functionally.

> Also, I think lttng-ust-pthread-mutex.c may be a more appropriate name
> than pthread.c

Wouldn't that just be redundant ? (And I actually expect the file to
grow instrumentation that's not mutex-specific.)

Thanks,
    Stefan

-- =


      ...ich hab' noch einen Koffer in Berlin...
