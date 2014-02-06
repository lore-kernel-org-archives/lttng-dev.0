From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Machine Interface
Date: Wed, 5 Feb 2014 21:42:19 -0500
Message-ID: <20140206024218.GD23121__20468.8925100074$1391654617$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WBEv6-0007GC-9c
	for lttng-dev@lists.lttng.org; Wed, 05 Feb 2014 21:42:33 -0500
Received: by mail-ig0-f177.google.com with SMTP id k19so4856161igc.4
	for <lttng-dev@lists.lttng.org>; Wed, 05 Feb 2014 18:42:22 -0800 (PST)
Received: from gmail.com (Sansfil-Securise-Etudiants-Poly-250-98.polymtl.ca.
	[132.207.250.98])
	by mx.google.com with ESMTPSA id ri2sm1920669igc.9.2014.02.05.18.42.21
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Wed, 05 Feb 2014 18:42:21 -0800 (PST)
Content-Disposition: inline
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

Hello all,

After speaking with Michel Dagenais, Genevi=E8ve Bastien, folks over at Eff=
iciOs
and Ericsson, a machine interface for lttng-tool would be a nice feature
to have. Olivier Cotte and me will be working on MI for the
next few weeks.

The main objective would be to reduce parsing complexity
in control tools.
ex:Regex used in TMF control service.
(org.eclipse.linuxtools.internal.lttng2.ui.views.control.service.LTTngContr=
olService.java)

Multiples solutions come to mind:
-XML
-JSON
-YAML
-Custom syntax (like GDB Machine interface* as proposed by Alexandre
				Montplaisir)

XML/JSON/YAML promote extensibility and ease of development for new tools
dependant on lttng-tools by being established standards.
On the other hand, they add dependencies to lttng-tools where a custom synt=
ax
would not.

Machine interface output would be generated only with --mi option and
could contain additional information than regular output.

We are focusing on output right now but we may eventually add a 'mi'
command for input if necessary.

What do you think ?

Thanks


*https://sourceware.org/gdb/onlinedocs/gdb/GDB_002fMI.html

-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
