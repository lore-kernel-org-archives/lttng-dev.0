From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: lttng command line user-friendliness
Date: Tue, 11 Sep 2012 09:22:04 +0200
Message-ID: <504EE69C.9090407__38124.4440716275$1347348121$gmane$org@mentor.com>
References: <504DCE2E.7020000@mentor.com> <504E0082.9040502@efficios.com>
	<504E099D.6030407@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TBKmq-0005UI-El
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 03:21:32 -0400
In-Reply-To: <504E099D.6030407@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 09/10/2012 05:39 PM, Woegerer, Paul wrote:
> On 09/10/2012 05:00 PM, David Goulet wrote:
>> With more options here to set either a custom destination or live
>> trace. What's the default? (no opts given). I would personally go for
>> a default one being to record in the session default trace files and
>> add a "-l" for the live.
>>
>>     -o, --output=3DDST
>>     -l, --live
>>
>> Add a domain option where nothing enables kernel AND ust or else the
>> command can take either -u or -k.
>>
>> Please, contribute to this, no bad ideas, only bad answers! :)

While sleeping over it two more things came to my mind:

*) The exit status of the <command> that gets trace-executed with "lttng =

trace <command> [<options>]" would need to be forwarded to the exit =

status of the wrapping lttng. This would allow users to use "lttng =

trace" as a drop-in replacement in contexts where the return value of =

the invoked <command> cannot be ignored.

*) There should be something like "-q [<logfile>], --quiet [<logfile>]" =

where the output of the traced <command> does not get mixed with lttng =

info/debug/error output. If the optional <logfile> is given all lttng =

relevant communication should go into the <logfile>.

Example without --quiet:

   Session met-2012-09-11_09-08-30 created.
   Traces will be written in =

/home/pwoegere/lttng-traces/met-2012-09-11_09-08-30-20120911-090830
   UST channel met_tools enabled for session met-2012-09-11_09-08-30
   UST event met_func:* created in channel met_tools
   UST event met_call:* created in channel met_tools
   Error: Events: Tracing the kernel requires a root lttng-sessiond =

daemon and "tracing" group user membership (channel channel0, session =

met-2012-09-11_09-08-30)
   Tracing started for session met-2012-09-11_09-08-30
   Solved
   MultiThread done...
   delta 131673329
   Tracing stopped for session met-2012-09-11_09-08-30
   Session met-2012-09-11_09-08-30 destroyed

Example with --quiet

   Solved
   MultiThread done...
   delta 131673329


--
PaulW


-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
