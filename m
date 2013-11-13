From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [PULL REQUEST babeltrace] Python bindings update
Date: Tue, 12 Nov 2013 22:06:41 -0500
Message-ID: <CA+jJMxsZLrpRXhgZDLqVfGgqjkz6_d=7NKPgRHr5gGc0vmc4TQ__22651.0011627854$1384312049$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VgQn1-0005aL-En
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 22:06:50 -0500
Received: by mail-qe0-f54.google.com with SMTP id 1so6242835qec.41
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 19:06:42 -0800 (PST)
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

Hi all,

Here are some patches to add read support of every CTF type using the
Babeltrace Python bindings. It is now possible to retrieve fields and
access their values using a single get_value() method returning native
Python objects. This is made possible using the work contributed by
one of our GSoC students, Xiaona Han.

These patches also make it possible to generate CTF from Python code,
based on the CTF Writer API that was merged recently.

The patches are available here:
https://github.com/jgalar/babeltrace/commits/bindings/python

7a30a66 Return event fields by field name
db551f2 Remove the unnecessary underscore prefix
4191bcd Support getting the value of enums
3c2ce77 Add a generic get_value() implementation
786207e Support for the sequence type
810a97b Add a python bindings sequence test
3043ee0 Remove Python 2 specific examples
90131a3 Fix: Throw a FieldError exception when get_value() fails
e5a73b9 Add support for floating point fields in the Python bindings
812e668 Add support for variant fields in the Python bindings
3a06891 Add support for structure fields in the Python bindings
cebae8c Fix: Python bindings array access functions write out of bounds
24d5c94 Rename the ctf class to CTFReader
ec8c88d Add CTF Writer Python bindings
033fb0a Add a usage example for the CTF Writer Python bindings
94a6cea Don't generate Python bindings by default
5491476 Expose text arrays the same way as regular arrays

Looking forward to your comments,
J=E9r=E9mie

-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
