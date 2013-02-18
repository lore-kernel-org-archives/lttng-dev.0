From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: How to disable an event that's been enabled by a
 wildcard selection or -a?
Date: Mon, 18 Feb 2013 09:47:22 +0100
Message-ID: <5121EA9A.8080905__41944.5587475368$1361177285$gmane$org@mentor.com>
References: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB19F968AF@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1U7MNX-0007bV-AJ
	for lttng-dev@lists.lttng.org; Mon, 18 Feb 2013 03:47:15 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F968AF@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David.OShea@quantum.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

On 02/14/2013 05:52 AM, David OShea wrote:
> Hi,
> =

> My understanding (hopefully someone will correct me if I'm wrong) is that=
 each time you invoke 'lttng enable-event', your specification for the even=
ts you want enabled is stored and applied, and/or potentially applied later=
 if a new application connects to the session daemon.  All 'lttng disable-e=
vent' does is remove one of the specifications you previously provided to '=
lttng enable-event', so you can't say 'enable-event *' and then 'disable-ev=
ent foo:*' to get all events except 'foo:*'.
> =

> If you could constrain the application to use a particular trace provider=
 name for all of its tracepoints, say "app", then you could just do 'lttng =
enable-event app:*'.  If you can't do that, then I think you need to fall b=
ack on getting a list of all the available tracepoints using 'lttng list -u=
', parsing this to find all of the available tracepoints, extracting the tr=
ace provider name from them, then using 'lttng enable-event <provider>:*' f=
or each provider other than the provider from your uninteresting library.  =
I think there are APIs that can be used instead of issuing the 'lttng' comm=
ands.
> =

> I would certainly also like a way to be able to, say, enable all events o=
ther than foo:* and bar:* using one command.

I submitted a patch that does exactly this a while ago:
http://lists.lttng.org/pipermail/lttng-dev/2012-June/018179.html

Although it's not upstream it works well for us.

Thanks,
Paul


> =

> Regards,
> David
> =

>> -----Original Message-----
>> From: Ikaheimonen, JP [mailto:jp_ikaheimonen@mentor.com]
>> Sent: Friday, 8 February 2013 7:56 PM
>> To: lttng-dev@lists.lttng.org
>> Subject: [lttng-dev] How to disable an event that's been enabled by a
>> wildcard selection or -a?
>>
>> Consider the following scenario.
>> I want to write a script that traces all UST tracepoints of a given
>> application. I have no idea what the names of these tracepoints are.
>> Also, I know that the application uses a library that contains some
>> tracepoints I am not interested about. Now I want to trace all UST
>> tracepoints except the ones I already know about. Is this possible with
>> the lttng commands?
>>
>> If I enable all tracepoints with "lttng enable-event -u -a" I get all
>> events, even those I do not want. I've tried using "lttng disable-
>> event", and "lttng enable-event" with a filter, but I cannot seem to be
>> able to get rid of the specific events.
>>
>> Thank you,
>>
>> JP Ikaheimonen
>> Mentor Graphics Embedded Systems Division
>> Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
>>
>> Android is a trademark of Google Inc. Use of this trademark is subject
>> to Google Permissions.
>> Linux is the registered trademark of Linus Torvalds in the U.S. and
>> other countries.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any d=
isclosure, copying, or further distribution of confidential information is =
not permitted unless such privilege is explicitly granted in writing by Qua=
ntum. Quantum reserves the right to have electronic communications, includi=
ng email and attachments, sent across its networks filtered through anti vi=
rus and spam software programs and retain such messages in order to comply =
with applicable data security and retention requirements. Quantum is not re=
sponsible for the proper and complete transmission of the substance of this=
 communication or for any delay in its receipt.
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =



-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
