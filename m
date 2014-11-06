From: Jon Bernard <jbernard@tuxion.com>
Subject: Re: [RELEASE] LTTng-Tools 2.5.2
Date: Thu, 6 Nov 2014 10:30:29 -0500
Message-ID: <20141106153029.GA15110__37727.8414009654$1415287889$gmane$org@helmut>
References: <CA+jJMxvphqKxboAqNOaHDfuSpVyC+HQZzscAoHaYif0xRNbCKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1XmP1B-0005VC-9g
 for lttng-dev@lists.lttng.org; Thu, 06 Nov 2014 10:30:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id DD65920C29
 for <lttng-dev@lists.lttng.org>; Thu,  6 Nov 2014 10:30:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CA+jJMxvphqKxboAqNOaHDfuSpVyC+HQZzscAoHaYif0xRNbCKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, maxime.hadjinlian@gmail.com
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> Hi all,
> =

> The lttng-tools project provides a session daemon (lttng-sessiond) that
> acts as a tracing registry, the "lttng" command line for tracing
> control, an lttng-ctl library for tracing control and an lttng-relay daem=
on
> to provide network streaming and live reading capabilities.
> =

> This is version 2.5.2 which includes an important fix to ensure that
> the live tracing feature works when applications run by multiple users
> are being traced.
> =

> Note that we have decided to remove lttng-tools 2.5.1 from the website
> since the tarball was packaged from the wrong tag. Special thanks to
> Maxime Hadjinlian for reporting the issue! [1]
> =

> 2014-11-05 lttng-tools 2.5.2
>         * Update maintainer section of the man pages
>         * Update maintainer section of README
>         * Fix: add README to documentation files
>         * Fix: UST consumer sync all available metadata

Debian has just froze for the next release,  but I can request an
exception for this version if you feel it's appropriate - it sounds like
it might be, but I want to make sure.

-- =

Jon
