From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: subsys.h?
Date: Tue, 24 Sep 2013 13:35:53 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26792B39__1297.87030532515$1380030504$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26792B0F@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvWQFZyr2HbHmUvGyDJqw=Emzc3boERTqFywVpCuRhw-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VOSmQ-0001bY-RW
	for lttng-dev@lists.lttng.org; Tue, 24 Sep 2013 09:36:00 -0400
In-Reply-To: <CA+jJMxvWQFZyr2HbHmUvGyDJqw=Emzc3boERTqFywVpCuRhw-g@mail.gmail.com>
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

> >    In https://www.kernel.org/doc/Documentation/trace/tracepoints.txt, t=
here is prominent mention of an "include/trace/events/subsys.h".  Where is =
that header supposed to be?  I can't find it in either of the kernel or ltt=
ng sources.
> >
>
> subsys is the name of your subsystem. There is no literal subsys.h file.
>
> J=E9r=E9mie

   Ah, that makes sense now.  The file should make that clear.  Perhaps cha=
nge:

In order to use tracepoints, you should include linux/tracepoint.h.

In include/trace/events/subsys.h :

#undef TRACE_SYSTEM

   Into:

In order to use tracepoints, you should include linux/tracepoint.h.

In include/trace/events/<subsys>.h (where <subsys> is the kernel sub-system=
 you want to add tracepoints to, such as 'block', 'power', or 'xen') :

#undef TRACE_SYSTEM

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
