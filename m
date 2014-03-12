From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: undefined reference to `lttng_probe_register'
Date: Wed, 12 Mar 2014 14:12:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2FFA0F2B__40163.0508401015$1394633640$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WNjtN-0008Cp-HS
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 10:12:30 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Wed, 12 Mar 2014 11:09:08 +0000
From: Ritchie Vickery <Ritchie.Vickery@imgtec.com>

> I'm trying to setup lttng for the first time.
>
> I've made librcu, lttng-ust, lttng-tools and lttng-modules and have instr=
umented some User code.
>
> I have run the tool to generate the tracepoint code:
> $ lttng-gen-tp ustrcv.tp -o ustrcv.h -o ustrcv.c
>
> However, at the point where the user-mode library containing ustrcv.o get=
s linked, I see the following error:
> /usr/local/include/lttng/ust-tracepoint-event.h:779: undefined reference =
to `lttng_probe_register'
>
> Does anyone have any ideas what I may have missed?
>
> Ritchie

   The error message sounds like /usr/local/lib/liblttng-ust-*.so are not b=
eing found.  Try specifying the /usr/local/lib path with your lttng-gen-tp =
call:

$ LDFLAGS=3D-L/usr/local/lib lttng-gen-tp ustrcv.tp -o ustrcv.h -o ustrcv.c

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
