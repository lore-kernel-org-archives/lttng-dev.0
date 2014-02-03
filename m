From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Human read-writeable format for CTF traces
Date: Mon, 03 Feb 2014 09:59:34 -0500
Message-ID: <52EFAED6.60304__39161.1110106625$1391439635$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1WAKzn-0003yD-A4
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 09:59:40 -0500
Received: from [132.207.72.9] ([132.207.72.9])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id s13ExYD7009041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Mon, 3 Feb 2014 09:59:34 -0500
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

Hello all,

Short question:

As we develop analyses in TMF for LTTng traces, we'd like to unit test =

them with very specific sequences of events, something no real-life =

trace can provide. We'd like to build our own traces manually.

Does a human read-writeable format already exist to work with CTF traces =

or convert from/to CTF traces? I heard of a few CTF trace generators, =

some which haven't been rebased in a while. What's their status? =

Anything that answers our need there?

Thanks,

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Detailed specification of what I'm looking for and why:

* In TMF, analyses use event requests and they handle events. It does =

not matter at all whether the event came from a CTF binary stream or =

from a text file, as long as they have the same name and fields, it will =

be handled the same.

* Also, while we may want to hand make a full test trace, we may also =

wish to take (part of) a real life CTF trace, convert it to a human =

read-writeable format, tweak it to our needs and... as far as TMF is =

concerned, we'll be perfectly happy with this format, but it may =

eventually be desirable to convert it back to a CTF trace.

* XML-defined analyses are about to make it into TMF master. That means =

users will be able to develop in XML their own state providers, but =

eventually also their own views, filters, analyses, etc. Before trying =

them on real traces, it must be possible to test them on controlled =

hand-made traces. So that trace format is not just a feature for unit =

tests, it should be made available in the main TMF for users to use.

* We must keep in mind that users of this format may not have access to =

the complete LTTng toolchain, or even to a linux command line as they =

may be working... on Windows! That's even more true now that work is =

being done to convert Windows traces to CTF format. So the solution must =

be completely standalone in TMF.

* In a quick prototype last week, I came up with this format for the =

human read-writeable test traces:

<trace>
<event>
<timestamp value=3D"1" />
<eventName value=3D"A" />
<source value=3D"0" /> /** the cpu */
<field name=3D"b" value=3D"1" type=3D"int" />
<field name=3D"c" value=3D"abcdef" type=3D"string" />
</event>
</trace>

Why XML? Because it's easy to validate with a XSD and we can use =

existing tool to automatically generate from this XSD a user interface =

to edit the events. But that's just a suggestion.

* Lastly and not least, whatever we end up implementing in TMF must use =

or at least play nice with other tools around CTF that do more or less =

the same thing. I wouldn't want to reinvent the wheel here.

Any thoughts?  Any thing I should look at?

Thanks,
Genevi=E8ve
