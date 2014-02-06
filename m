From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Machine Interface
Date: Thu, 6 Feb 2014 08:32:20 -0500
Message-ID: <CAFXXi0=enX3ERpH1Q3R-P4ii2wU7TE2wX_NEcXYF0iEXKCW6yA__10729.7395392836$1391693625$gmane$org@mail.gmail.com>
References: <20140206024218.GD23121@gmail.com> <52F33CBA.5000802@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1WBP4a-0004FX-3D
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 08:32:57 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so634668ieb.28
	for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2014 05:32:50 -0800 (PST)
In-Reply-To: <52F33CBA.5000802@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 6 February 2014 02:41, Woegerer, Paul <Paul_Woegerer@mentor.com> wrote:
> On 02/06/2014 03:42 AM, Jonathan Rajotte wrote:
>> Hello all,
>>
>> After speaking with Michel Dagenais, Genevi=E8ve Bastien, folks over at =
EfficiOs
>> and Ericsson, a machine interface for lttng-tool would be a nice feature
>> to have. Olivier Cotte and me will be working on MI for the
>> next few weeks.
>>
>> The main objective would be to reduce parsing complexity
>> in control tools.
>> ex:Regex used in TMF control service.
>> (org.eclipse.linuxtools.internal.lttng2.ui.views.control.service.LTTngCo=
ntrolService.java)
>>
>> Multiples solutions come to mind:
>> -XML
>> -JSON
>> -YAML
>
> YAML sounds very attractive in this context.

I am also fond of the yaml syntax. It is very easy to read/write by a
human. Not sure how much this matters though, since is a machine
interface.

> It's easily parseable even from a shell script. If you need to automate
> LTTng tracing tasks on a small embedded target busybox is all you have!

This point is relevant for me, since I actually intend to use this to
enhance bash completion, which is done with a bash script.

I never thought I would say that one day, but I think that XML could
have an advantage here. Parsing yaml with regexp (such as in a shell
script) is easier than XML, but it's still not bulletproof. Consider
this eventual yaml structure I just made up for the output of the
session list.

sessions:
  - name: my_session
    domain: kernel
    events:
      - name: sched_switch
        filter: prev_pid =3D=3D 1234
      - name: sched_migrate_task
        otherproperty: "something"
  - name: another_session
    domain: ust
    events:
      - name: event_hello
      - name: event_bonjour
        loglevel: 3

If you want to get the list of sessions, you'll probably want to grep
the "name: " entries, but then event names would match as well. Of
course, names could be different, or you could grep for the
appropriate amount of spaces/tabs at the beginning of the line. But
then it also depends if the name dictionary entry is the first, then
it will have a "-" in front... It's possible, but it will also be very
easy to break scripts.

With XML, there are tools (xmlstarlet, xmllint, probably others) that
allow you to evaluate XPath expressions and thus not depend of the
formatting. For example, an equivalent XML schema could be

<lttng>
  <session name=3D"my_session" domain=3D"kernel">
    <event name=3D"sched_switch" filter=3D"prev_pid =3D=3D 1234" />
    <event name=3D"sched_migrate_task" otherproperty=3D"something" />
  </session>
  <session name=3D"another_session" domain=3D"ust">
    <event name=3D"event_hello" />
    <event name=3D"event_bonjour" loglevel=3D"3" />
  </session>
</lttng>

To get a plain list of sessions, you could then do

$ lttng list --mi | xmlstarlet sel -T -t -v "/lttng/session/@name" -n
my_session
another_session

Maybe such tools exist for yaml?

Also, I understand your point for embedded devices though, where space
is limited and you don't want to load an XML lib/tool just for that.
If the design of the MI is somewhat modular though, it could be
possible to support more than one output format, with the different
options available at configure time.


> Best,
> Paul
>
>> -Custom syntax (like GDB Machine interface* as proposed by Alexandre
>>                               Montplaisir)

I would suggest not going for a custom syntax... that sounds like more
work for more chances of bugs.

>> XML/JSON/YAML promote extensibility and ease of development for new tools
>> dependant on lttng-tools by being established standards.
>> On the other hand, they add dependencies to lttng-tools where a custom s=
yntax
>> would not.

I would suggest making the dependency optional. If you don't have the
lib, or don't want to depend on the lib, have a --disable-something at
configure time.

>> Machine interface output would be generated only with --mi option and
>> could contain additional information than regular output.
>>
>> We are focusing on output right now but we may eventually add a 'mi'
>> command for input if necessary.
>>
>> What do you think ?
>>
>> Thanks
>>
>>
>> *https://sourceware.org/gdb/onlinedocs/gdb/GDB_002fMI.html
>>
>
>
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
