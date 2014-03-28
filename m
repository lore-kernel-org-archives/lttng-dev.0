From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Issue with UST tracing - unable to view CTF traces
Date: Fri, 28 Mar 2014 13:27:42 -0400
Message-ID: <CA+jJMxsZwNnmb4H0DYSpS8cemx+Jm5Orww-CTnWmJaBcx1PpGg__11837.8448104069$1396027727$gmane$org@mail.gmail.com>
References: <7dc17672df8141e3af8a275931834909@Perses.usurf.usu.edu>
 <CA+jJMxs5U9LHUyWm+h-dm7LuTamv7NQG4DwUSyNjFUPUvOSDNw@mail.gmail.com>
 <7f23634aef534feaaa2083a424f38a81@Perses.usurf.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WTaZH-0002L2-Nb
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 13:27:50 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so4641700qge.17
 for <lttng-dev@lists.lttng.org>; Fri, 28 Mar 2014 10:27:42 -0700 (PDT)
In-Reply-To: <7f23634aef534feaaa2083a424f38a81@Perses.usurf.usu.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 28, 2014 at 12:58 PM, Jonathan Haws
<Jonathan.Haws@sdl.usu.edu> wrote:
>
>> > I am having a problem with UST tracing on my system.  My setup is as f=
ollows:
>> >
>> > I have my development system running Xubuntu 12.04 LTS with the LTTng =
ppa enabled, so I am running the 2.4.0 tools.  I have my embedded target ru=
nning manually compiled 2.4.0 tools (it's distro is Fedora 17 right now).
>> >
>> > Last week things were working just fine, but I made some changes to my=
 template file and something broke, but I can't figure out what is up.
>> >
>>
>> What do you mean by template file?
>
> I mean the file used to generate the source using lttng-gen-tp.  That is =
attached.
>
>
>>
>> >
>> > When I try to import traces into the Eclipse tools, I get the followin=
g error:
>> >
>> > org.eclipse.linuxtools.tmf.core.exceptions.TmfTraceException: Mismatch=
edTokenException(LPAREN!=3DTERM) at metadata:204
>> >
>> >
>> > When I try to open with babeltrace, I get the following:
>> >
>> > jhaws@verde:~/trace$ babeltrace sms/SMS-20110922-130857/ust
>> > [error] at line 199: token "(": syntax error, unexpected LPAREN, expec=
ting SEMICOLON or COMMA
>> >
>> > [error] Error creating AST
>> > [warning] Unable to open trace metadata for path "sms/SMS-20110922-130=
857/ust/uid/0/64-bit".
>> > [warning] [Context] Cannot open_trace of format ctf at path sms/SMS-20=
110922-130857/ust/uid/0/64-bit.
>> > [warning] [Context] cannot open trace "sms/SMS-20110922-130857/ust/uid=
/0/64-bit" from sms/SMS-20110922-130857/ust for reading.
>> > [error] Cannot open any trace for reading.
>> >
>> > [error] opening trace "sms/SMS-20110922-130857/ust" for reading.
>> >
>> > [error] none of the specified trace paths could be opened.
>> >
>> >
>> > What am I doing wrong?  Things were working great before, but now some=
thing is up. What are the chances that there is a compatibility issue betwe=
en the two installations?
>> >
>
>> Could you share the trace?
>
> Attached in zip format.  Thanks!

Looking at the trace, line 199 in the metadata file immediatly stands out.

> integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base=
 =3D 10; } _(*__errno_location ());

The problem is that you use "errno" is your template, which is defined
by glibc as
#   define errno (*__errno_location ())

You'll have to use a different field name.

Regards,
J=E9r=E9mie

-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
