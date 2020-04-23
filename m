From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: [RELEASE  Babeltrace 2.0.3 - Amqui
Date: Thu, 23 Apr 2020 18:01:40 -0400
Message-ID: <20200423220140.GA371570@gmail.com>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 497WVK1xksz1jXX
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 18:01:45 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id 71so6289911qtc.12
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 15:01:45 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone!

Today we're releasing the third patch-level release of Babeltrace 2.0
"Amqui".

What's new since Babeltrace 2.0.2?
==================================

This release contains a number of fixes, but more importantly an
initial documentation for the Python bindings.

Note that I messed up and pushed out a later commit tagged as v2.0.3
and retagged the release commit as v2.0.3 again.

If you got the wrong tag, and want the new one, please delete the old
one and fetch the new one by doing:

	git tag -d v2.0.3
	git fetch origin tag v2.0.3

to get the updated tag.

You can test which tag you have by doing

	git rev-parse v2.0.3

which should return 91d15447 if you have the new version.

Sorry for the inconvenience.

The full change log follows.

2020-04-24 Babeltrace 2.0.3 (German Beer Day)
	* Fix: lib: use appropriate format specifier to print message iterator class
	* Fix: sink.text.pretty: check that port is connected before creating message iterator
	* Add initial Python bindings documentation
	* Fix: bt2: read properties on _DiscardedEventsMessage
	* tests: add tests for discarded events/packets creation
	* Fix: bt2: add precond. check, for stream class supporting discarded msgs with clock snapshot without clock class
	* Fix: flt-utils.muxer: reference leak in muxer_msg_iter_add_upstream_msg_iter error path
	* Fix: sink.text.details: goto error when failing to add input port
	* Fix: src.text.dmesg: add missing assignment of `status` on error path
	* Revert "bt2: _EventConst.__getitem__(): use a single temporary variable"
	* Fix: src.ctf.fs: initialize the other_entry variable
	* bt2: _EventConst.__getitem__(): use a single temporary variable
	* Fix: _EventConst.__getitem__(): check if event has a packet
	* doc: bt_field_class...get_mapping_labels...(): clarify RV's validity
	* doc/api/libbabeltrace2/style.css: make font weight of `.intertd` normal
	* Update working version to Babeltrace 2.0.3

Important links
===============
Babeltrace 2.0.3 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.0.3.tar.bz2

Babeltrace website:
    https://babeltrace.org

Mailing list (for support and development):
    `lttng-dev at lists.lttng.org`

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    https://bugs.lttng.org/projects/babeltrace

GitHub project:
    https://github.com/efficios/babeltrace

Continuous integration:
    https://ci.lttng.org/view/Babeltrace/

Code review:
    https://review.lttng.org/q/project:babeltrace
