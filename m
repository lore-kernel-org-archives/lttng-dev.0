From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Help needed in getting first ust event running	(was
	Re: lttng-dev Digest, Vol 60, Issue 31)
Date: Thu, 18 Apr 2013 16:32:43 -0400
Message-ID: <20130418203243.GA1135__21990.9946471036$1366317189$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D0EF0F@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1USvVc-0006z6-VC
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 16:32:45 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D0EF0F@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> > The kernel modules are indeed not needed for userspace tracing.
> >
> > I'm guessing you installed from source since the lttng libs don't seem
> > present in your path. Could tell us on which revision this is
> > happening?
> >
> > Also, perhaps you could try Mathieu's recently commited fix? It may be =
related.[1]
> > [1] http://lists.lttng.org/pipermail/lttng-dev/2013-April/020064.html
> =

>    Yup, it was the same problem.  I've just rebuilt using the latest
>    userspace-ust and lttng-ust, and the user-space-only trace was
>    generated without a hitch on a system without lttng-modules.  I've
>    checked both the static and dynamic easy-ust samples.

did you run ldconfig on the machine without lttng-modules ?

does this machine recognise libraries in /usr/local automatically (see
/etc/ld.so.conf) ?

lttng-modules is completely unrelated to user-space tracing.

Thanks,

Mathieu

> =

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
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
