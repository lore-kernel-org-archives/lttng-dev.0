From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Machine Interface
Date: Thu, 6 Feb 2014 08:41:46 +0100
Message-ID: <52F33CBA.5000802__16789.7184881896$1391672637$gmane$org@mentor.com>
References: <20140206024218.GD23121@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WBJcB-0001F5-GO
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 02:43:16 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1WBJc5-0006rb-7A from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 05 Feb 2014 23:43:09 -0800
In-Reply-To: <20140206024218.GD23121@gmail.com>
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

On 02/06/2014 03:42 AM, Jonathan Rajotte wrote:
> Hello all,
>
> After speaking with Michel Dagenais, Genevi=E8ve Bastien, folks over at E=
fficiOs
> and Ericsson, a machine interface for lttng-tool would be a nice feature
> to have. Olivier Cotte and me will be working on MI for the
> next few weeks.
>
> The main objective would be to reduce parsing complexity
> in control tools.
> ex:Regex used in TMF control service.
> (org.eclipse.linuxtools.internal.lttng2.ui.views.control.service.LTTngCon=
trolService.java)
>
> Multiples solutions come to mind:
> -XML
> -JSON
> -YAML

YAML sounds very attractive in this context.

It's easily parseable even from a shell script. If you need to automate
LTTng tracing tasks on a small embedded target busybox is all you have!

Best,
Paul

> -Custom syntax (like GDB Machine interface* as proposed by Alexandre
> 				Montplaisir)
>
> XML/JSON/YAML promote extensibility and ease of development for new tools
> dependant on lttng-tools by being established standards.
> On the other hand, they add dependencies to lttng-tools where a custom sy=
ntax
> would not.
>
> Machine interface output would be generated only with --mi option and
> could contain additional information than regular output.
>
> We are focusing on output right now but we may eventually add a 'mi'
> command for input if necessary.
>
> What do you think ?
>
> Thanks
>
>
> *https://sourceware.org/gdb/onlinedocs/gdb/GDB_002fMI.html
>


-- =

Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
