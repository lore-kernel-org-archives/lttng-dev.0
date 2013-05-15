From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Remove extra quote after	an
	include directive
Date: Wed, 15 May 2013 15:05:43 -0400
Message-ID: <20130515190543.GA12448__35319.7928904139$1368644788$gmane$org@Krystal>
References: <1368635955-13695-1-git-send-email-jeremie.galarneau@efficios.com>
	<20130515165030.GA10924@Krystal>
	<CA+jJMxv2ApjX7RM6UdvRggSp-K1ApJfobsXtqrMFu0T++_Y0pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uch1H-00081c-2r
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 15:05:47 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxv2ApjX7RM6UdvRggSp-K1ApJfobsXtqrMFu0T++_Y0pQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> It was introduced here:
> https://bugs.lttng.org/projects/babeltrace/repository/revisions/4cb26dfbd=
763c06d99bf1069e2d1f3a569858e32/diff

OK, I was probably looking at the wrong file.

Merged, thanks!

Mathieu

> =

> On Wed, May 15, 2013 at 12:50 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > in which tree did you find this ?
> >
> > * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> >> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> >> ---
> >>  formats/ctf/ctf.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> >> index b27f2ec..bb94e52 100644
> >> --- a/formats/ctf/ctf.c
> >> +++ b/formats/ctf/ctf.c
> >> @@ -51,7 +51,7 @@
> >>  #include "metadata/ctf-parser.h"
> >>  #include "metadata/ctf-ast.h"
> >>  #include "events-private.h"
> >> -#include <babeltrace/compat/memstream.h>"
> >> +#include <babeltrace/compat/memstream.h>
> >>
> >>  #define LOG2_CHAR_BIT        3
> >>
> >> --
> >> 1.8.2.2
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
