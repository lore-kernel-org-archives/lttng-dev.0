From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Mon, 29 Jul 2013 14:22:14 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1BE24AB8__35395.5721985132$1375107808$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvi52qeC_Gcxg5+DrXfKfV7Nt2pvxaUtEwoopqZ3hZ-VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V3oLJ-0001iH-Lv
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 10:22:39 -0400
In-Reply-To: <CA+jJMxvi52qeC_Gcxg5+DrXfKfV7Nt2pvxaUtEwoopqZ3hZ-VQ@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Envoy=E9=A0: 29 juillet 2013 10:20

On Mon, Jul 29, 2013 at 9:49 AM, Thibault, Daniel <Daniel.Thibault@drdc-rdd=
c.gc.ca> wrote:
> > ----------------------------------------------------------------------
> >    Unless I'm mistaken, currently lttng's 'enable-event -u ...' works o=
nly on already-running user-space processes.  It should be fairly easy to c=
hange this so the event gets enabled for any new user-space process that re=
gisters itself with the session daemon while the session is in existence.  =
This would be possible only for instrumented applications, of course.  It s=
hould also be possible to extend this to uninstrumented applications, as lo=
ng as the session daemon watches for new processes being launched.
> >
>
> lttng enable-event -u also works for processes that are not yet launched.

   Cool!

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
