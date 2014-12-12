From: Yan Grange <ygrange@gmail.com>
Subject: Re: Errors compiling converted tp file
Date: Fri, 12 Dec 2014 11:59:40 +0100
Message-ID: <BE7D65EA-876D-4CB9-A935-659200D5BE77__44007.0052668036$1418400647$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <9F3E07F7-AA26-49A3-BE48-E117868890E2@gmail.com>
 <CA+jJMxuf5wHG2MBSh4bFmn=BOi2b=O2vH+THT9mphVZR0_asfw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ygrange@gmail.com>) id 1XzNwr-0007Sa-6n
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 05:59:51 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so8723552wgh.30
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 02:59:43 -0800 (PST)
In-Reply-To: <CA+jJMxuf5wHG2MBSh4bFmn=BOi2b=O2vH+THT9mphVZR0_asfw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?windows-1252?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
 Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi,

Let me start by thanking you for all the support you give (it is impressing=
ly fast).

So if I look in the repo, with the ppa installed, I can't find liburcu:

$ cat /etc/apt/sources.list.d/lttng-ppa-precise.list
deb http://ppa.launchpad.net/lttng/ppa/ubuntu precise main
deb-src http://ppa.launchpad.net/lttng/ppa/ubuntu precise main

(I have asked my admin to do an apt-get update)

$ apt-cache search lttng
lttng-modules-dkms - Linux Trace Toolkit (LTTng) kernel modules (DKMS)
lttng-tools - LTTng control and utility programs
liblttng-ust0 - LTTng 2.0 Userspace Tracer (libraries)
liblttng-ust-dev - LTTng 2.0 Userspace Tracer (development files)
liblttng-ctl-dev - LTTng control and utility library (development files)
liblttng-ctl0 - LTTng control and utility library
liblttng-ust-java-jni - LTTng 2.0 Userspace Tracer (JNI interface)
liblttng-ust-java - LTTng 2.0 Userspace Tracer (Java support library)
python-lttng - Python bindings for LTTng
liblttng-ust-ctl2 - LTTng 2.0 Userspace Tracer (trace control library)

$ apt-cache search liburcu
liburcu-dev - a userspace RCU (read-copy-update) library - development files
liburcu1 - a userspace RCU (read-copy-update) library
liburcu2 - a userspace RCU (read-copy-update) library

So it looks like my aptitude is not aware of a package called liburcu witho=
ut a postfix=85 Even if I'd purge and reinstall (which seems like a very go=
od idea) I don't see if I can access the right library this way.

Cheers

Yan Grange

On 11 dec. 2014, at 18:08, J=E9r=E9mie Galarneau <jeremie.galarneau@efficio=
s.com> wrote:

> On Thu, Dec 11, 2014 at 8:56 AM, Yan Grange <ygrange@gmail.com> wrote:
>> Hi,
>> =

>> I can't really make out
>>> =

>>>> However it actually works to create a header file from a tp file and c=
ompile (and run) the code. However I now get in trouble when executing:
>>>> =

>>>> $ lttng list --userspace
>>>> Error: Unable to list UST events: Undefined command
>>>> Error: Command error
>>>> =

>>>> So I guess something still went somewhat wrong but I can't really see =
what.
>>>> =

>>>> Yan Grange
>>> =

>>>  In order to trace user-space, you must install, in sequence, the follo=
wing packages: userspace-rcu, lttng-ust, lttng-tools.  Was this done?
>>> =

>> I tried to install the right packages but there don't seem to be package=
s named like that in either the ubuntu repository or the ppa provided by yo=
u.
>> =

>> I have the following packages installed:
>> lttng-tools
>> liblttng-ust0
>> liblttng-ust-dev
>> liblttng-ust-ctl2
>> liblttng-ctl0
>> liburcu-dev
>> liburcu2
> =

> Some of these packages appear to be conflicting. You'd be better off
> removing them all and starting fresh from the PPA.
> =

> J=E9r=E9mie
> =

>> =

>> With all this installed, I still don't get it to work.
>> =

>> Cheers
>> =

>> Yan Grange
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
