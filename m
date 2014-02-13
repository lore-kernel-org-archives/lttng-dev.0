From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Machine Interface
Date: Thu, 13 Feb 2014 15:36:28 -0500
Message-ID: <20140213203627.GC16437__3991.60045567459$1392323861$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267E7531@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WE31Q-0003BF-UZ
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 15:36:42 -0500
Received: by mail-ig0-f169.google.com with SMTP id uq10so4265953igb.0
	for <lttng-dev@lists.lttng.org>; Thu, 13 Feb 2014 12:36:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267E7531@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

> > Now for the machine interface syntax:
> >
> >   * Also, to avoid confusion we will use a different primary command fo=
r input and
> >     output machine interface.
> >		Ex: lttng machine <input>
> >		Ex: lttng --xml <output>

This should be :
		for MI input: lttng machine <input>
		for XML output: lttng <command> <command-option> --xml

--xml would be an option for each command
> =

>    I have a problem with the broken symmetry here.  If you have a command=
 (e.g. 'machine') for input, why is it you have none for output?  What happ=
ens if, for instance, I type 'lttng --xml list -k'?  Am I going to get an x=
ml-formatted list of kernel tracepoints to stdout?
>
The syntax would be: lttng list -k --xml
and the output would be an xml-formatted list of kernel tracepoints to
stdout.


> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
