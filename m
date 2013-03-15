From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Fri, 15 Mar 2013 15:33:11 -0400
Message-ID: <CA+jJMxvm5=mms0BwFtDEy8CKuYOM08K7EYCddKWoRY2VSbxV1Q__3088.03419252417$1363376047$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD027A2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f180.google.com ([74.125.82.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UGaNR-00042O-Pm
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 15:33:18 -0400
Received: by mail-we0-f180.google.com with SMTP id k14so3440952wer.25
	for <lttng-dev@lists.lttng.org>; Fri, 15 Mar 2013 12:33:11 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD027A2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 15, 2013 at 12:41 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>    In the lttng-ust man pages, there is a paragraph that reads:
>
> Note about dlopen() usage: Due to locking side-effects caused by the way =
libc lazily resolves Thread-Local Storage (TLS) symbols when a library is d=
lopened, linking the tracepoint probe or liblttng-ust with dlopen() is disc=
ouraged.  They should be linked with the application using "-llibname" or l=
oaded with LD_PRELOAD.
>
>    I'm confused by the LD_PRELOAD bit: as far as I know, LD_PRELOAD serve=
s only to substitute a dynamic library (the LD_PRELOAD argument) for anothe=
r (the one the executable was linked against).  I don't see how one could c=
ompile an instrumented application and leave its tracepoint provider unlink=
ed, which is what the stated -llibname <-> LD_PRELOAD opposition implies.
>

You may want to have a look at the comment at
lttng-ust/include/lttng/tracepoint.h:229 which explains how this is
accomplished. Basically, the tracepoint provider symbols are
initialised and the probe is registered when the provider's shared
object constructor is invoked. See ust-tracepoint-event.h:671 if you
are interested in the actual implementation.

>    (Also, shouldn't that paragraph drop 'lazily', assuming the locking pr=
oblems also arise if dlopen is used with RTLD_NOW?  Because if RTLD_NOW fix=
ed the locking problem, that's what would be recommended here, no?)

Good question. I think this problem has been fixed as part of the 2.1
release. However, I do know there are other issues related to
"dlopen()"-ing probe providers; details on the bug tracker[1].

J=E9r=E9mie
[1] https://bugs.lttng.org/issues/447

>
> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
