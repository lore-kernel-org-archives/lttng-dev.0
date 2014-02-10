From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RFC lttng-tools] Save and restore feature
Date: Mon, 10 Feb 2014 13:44:15 -0500
Message-ID: <CA+jJMxvGgEzVdg85aL=ucyfn9hS+Tg6duyJpfUbcqyZh32Lemg__44480.2248887301$1392058224$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WCvq9-0001Jp-G0
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 13:44:27 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so10247511qap.30
	for <lttng-dev@lists.lttng.org>; Mon, 10 Feb 2014 10:44:16 -0800 (PST)
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

I'd like to submit the following patches from my personal lttng-tools
branch for merge in master[1].

a923fbe - session_find_by_name does not need a non-const name parameter
7fca51a - Fix: tcp4 and net4 protocol support in uri_parse
e6fc6a3 - Send filter expression string to session daemon
904fbd7 - Add a dependency to libxml2
dc9e590 - Add a config_writer API based on libxml2
c3e9d95 - Add session configuration XSD
afced3a - Add a save API to lttng-ctl
a933bdf - Add session configuration save feature to session daemon
79a9e3d - Add a save command based on the save API to the lttng client
7ae1b6b - Add session configuration load capability to libconfig
7e4b250 - Add load command to the lttng client

These patches add the ability to save and restore session
configurations using the lttng command-line client. The session
configurations are saved as XML following a schema which is included
in the patches.

Quick user guide to try out this feature:

# Create a session as usual
lttng create my_session
lttng enable-event -k -a
lttng enable-event -u -a
lttng add-context -k -t perf:cache-misses

# Save.. This will create a my_session.lttng file under ~/.lttng/sessions
lttng save my_session

# Destroy the session
lttng destroy

# Load the session... lttng will look in the user's home directory and
# in the system trace configuration directory (/etc/lttng/sessions)
for a session
# matching this name and load it.
lttng load my_session

Looking forward to your comments,
J=E9r=E9mie

[1] https://github.com/jgalar/lttng-tools.git

-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
