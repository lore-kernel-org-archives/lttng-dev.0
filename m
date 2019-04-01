From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: check for lttng-modules
 presence
Date: Mon, 1 Apr 2019 16:26:15 -0400
Message-ID: <20190401202615.GA28595__28666.987775226$1554150542$gmane$org@joraj-alpa>
References: <20190325184939.24845-1-jonathan.rajotte-julien@efficios.com>
 <20190329181555.GB28162@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Y3lK1xy0z18GX
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 16:26:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190329181555.GB28162@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

On Fri, Mar 29, 2019 at 02:15:56PM -0400, J=E9r=E9mie Galarneau wrote:
> Merged in master, stable-2.11, and stable-2.10.

Note that to be valid on stable-2.10 you will also have to backport another
patch. 2.11 is okai.

9c8a396496a28702730192ae1ded06105c54c5dc on master.

> =

> Thanks!
> J=E9r=E9mie
> =

> On Mon, Mar 25, 2019 at 02:49:39PM -0400, Jonathan Rajotte wrote:
> > Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> > ---
> >  tests/regression/tools/notification/test_notification_kernel | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/tests/regression/tools/notification/test_notification_kern=
el b/tests/regression/tools/notification/test_notification_kernel
> > index 6d7f256ae..e7368df26 100755
> > --- a/tests/regression/tools/notification/test_notification_kernel
> > +++ b/tests/regression/tools/notification/test_notification_kernel
> > @@ -108,6 +108,7 @@ function kernel_test
> >  }
> >  =

> >  if [ "$(id -u)" =3D=3D "0" ]; then
> > +	validate_lttng_modules_present
> >  	kernel_test
> >  else
> >  	# Kernel tests are skipped.
> > -- =

> > 2.17.1
> > =


-- =

Jonathan Rajotte-Julien
EfficiOS
