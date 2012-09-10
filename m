From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: lttng command line user-friendliness
Date: Mon, 10 Sep 2012 13:25:34 +0200
Message-ID: <504DCE2E.7020000__40969.0637876794$1347276329$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TB26l-0004oL-6o
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 07:24:51 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1TB26e-0005Gg-Ue from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 04:24:44 -0700
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

As much as I like the lttng command line tool (that we have since =

LTTng2) I still see people (who are not yet familiar with lttng) =

struggle with the simple fact that it takes more than one command to =

actually get something traced.

Issuing a sequence of commands like:

lttng create
lttng enable-event -u -a
lttng start
my_foobar_traced_application 1 2 3
lttng stop
lttng destroy

seems to be perceived as complicated compared to:

perf record -- my_foobar_traced_application 1 2 3

My argument usually is that providing detailed settings as options (like =

perf) does not scale as well as the lttng approach (if you have more =

things to configure). On the other hand most users just want something =

like the above. Also arguing that they should write a shell-script that =

encodes their use case generally causes irritation ("... please =

understand, I do not want to write a shell-script I just want to do =

simple tracing of my executable ...").

What about adding something similar to "perf record" to lower the =

barrier for such users. For example:

lttng record [--session-name <name>] [--session-template =

<session_template_file>]  -- <command> [<options>]

Where the optional session_template_file may only contain =

"enable-channel, enable-event and add-context" commands. If omitted the =

following could be the (trivial) default session template:

enable-event -u -a


Would this make sense for others as well ? Any alternative suggestions ?

Thanks,
Paul

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.wwwhich		=
