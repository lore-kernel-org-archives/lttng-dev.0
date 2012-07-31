From: David Goulet <david.goulet@polymtl.ca>
Subject: [RFC] LTTng address API proposal
Date: Tue, 31 Jul 2012 12:13:12 -0400
Message-ID: <50180418.5020904__30739.9886347868$1343751228$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030203090508040503010803"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwF4Q-0006mq-MW
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 12:13:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 0E762187210
	for <lttng-dev@lists.lttng.org>; Tue, 31 Jul 2012 12:14:05 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvxDExK9Xj3l for <lttng-dev@lists.lttng.org>;
	Tue, 31 Jul 2012 12:14:02 -0400 (EDT)
Received: from [128.0.0.103] (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 2D8B2187208
	for <lttng-dev@lists.lttng.org>; Tue, 31 Jul 2012 12:14:02 -0400 (EDT)
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

This is a multi-part message in MIME format.
--------------030203090508040503010803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This follows the discussion on IRC #lttng which aims at removing the lttng_uri
structure from the public API.

Cheers!
David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGAQYAAoJEELoaioR9I02lUYH/i/8/ynJKBbCbKd7JGG4hKwo
QG1ECZvbujSLkZPAG81sYtrj1kPlDC54Bu+rajTcMeusJ937o2AXvjT+KgesZF0P
4cGHM64WQ7wK4Y/nJE3JQ2dHdytP2KEizN4YWW8MERgKdx/TlN28wL08zRGxKC19
/Lo51OS3lpYgAUmezNWjncQ/xBmlsW6zFzGPgPt6jmN3rfKdgXVE+ArWStUOn9uk
BwfXT+hk0WGt/8ykG7qxPDAyBeS1dH1lJpCrjcZKEBUBXose85JvtioI1b5nkX1F
YHQM7IFH9PpykYLqVhCVTe/0ukjIl9zyBBhTak4l+ShGeGYR0M8rLdXUbQDDriU=
=m3Bn
-----END PGP SIGNATURE-----

--------------030203090508040503010803
Content-Type: text/plain;
 name="0004-lttng-address-api.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0004-lttng-address-api.txt"

UkZDIC0gTFRUbmcgYWRkcmVzcyBBUEkgcHJvcG9zYWwKCkF1dGhvcjogRGF2aWQgR291bGV0
IDxkYXZpZC5nb3VsZXRAZWZmaWNpb3MuY29tPgoKQ29udHJpYnV0b3JzOgogICAgKiBNYXRo
aWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgoJKiBZYW5u
aWNrIEJyb3NzZWF1IDx5YW5uaWNrLmJyb3NzZWF1QHBvbHltdGwuY2E+CgpWZXJzaW9uOgog
ICAgLSB2MC4xOiAzMS8wNy8yMDEyCiAgICAgICAgKiBJbml0aWFsIHByb3Bvc2FsCgpJbnRy
b2R1Y3Rpb24KLS0tLS0tLS0tLS0tLS0tLS0KClRoaXMgZG9jdW1lbnQgcHJvcG9zZXMgdGhl
IHVzZSBvZiBzdHJpbmcgVVJMcyB0byB0aGUgY29tbWFuZCBsaW5lIGludGVyZmFjZSBhbmQK
QVBJIHdoaWNoIHdpbGwgZGVwcmVjYXRlIGEgZnVuY3Rpb24gYW5kIHByb3Bvc2UgbmV3IG9u
ZXMuCgpUaGUgcHVycG9zZSBvZiB0aGlzIHByb3Bvc2FsIGlzIHRvIHN1cHBvcnQgbmV0d29y
ayBzdHJlYW1pbmcgdXNpbmcgVVJMIHN0cmluZwpmb3JtYXQgdGhhdCB5b3UgY2FuIGZpbmQg
aW4gcHJvcG9zYWwgZG9jL3Byb3Bvc2Fscy8wMDAzLW5ldHdvcmsuY29uc3VtZXIudHh0LApy
ZW1vdmUgdGhlIGx0dG5nX3VyaSBzdHJ1Y3R1cmUgZnJvbSB0aGUgQVBJIGFuZCBpbnRlZ3Jh
dGUgdGhlIFVSTCBzdHJpbmcgdG8gdGhlCkFQSS4KCkFQSQotLS0tLS0tLS0tLS0tLS0tLQoK
SW4gb3JkZXIgbm90IHRvIGV4cG9zZSB0aGUgbmV3IGx0dG5nX3VyaSBzdHJ1Y3R1cmUgdXNl
ZCB0byBpZGVudGlmeSB0cmFjZQpsb2NhdGlvbiBmb3IgbHR0bmcgY29uc3VtZXIsIHRoZSBw
dWJsaWMgQVBJIHdpbGwgb25seSB1c2Ugc3RyaW5nIGFkZHJlc3Mgd2hlcmUKaXQgd2lsbCBi
ZSBjb252ZXJ0ZWQgaW4gYSBsdHRuZ191cmkgYW5kIHNlbnQgdG8gdGhlIHNlc3Npb24gZGFl
bW9uLgoKWypdIENyZWF0ZSBzZXNzaW9uOgoKV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRo
ZSBlbmFibGUtY29uc3VtZXIgY29tbWFuZCB1c2VkIGZvciBuZXR3b3JrIHN0cmVhbWluZywK
dGhlIGNyZWF0ZSBzZXNzaW9uIGNvbW1hbmQgaGFzIGJlZW4gbW9kaWZpZWQgc28gdGhlIHVz
ZXIgY291bGQgZGVmaW5lIGEgY29uc3VtZXIKbG9jYXRpb24gZWl0aGVyIG9uIHRoZSBuZXR3
b3JrIG9yIGxvY2FsIHdpdGggdGhlIGNvbW1hbmQuIFRoaXMgY2hhbmdlIGRlcHJlY2F0ZXMK
dGhlIG9sZCBBUEkgZnVuY3Rpb24gYW5kIGFkZHMgYSBuZXcgb25lLgoKRGVwcmVjYXRlZDoK
LS0+IGx0dG5nX2NyZWF0ZV9zZXNzaW9uKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIg
KnBhdGgpOwoKUHJvcG9zZWQ6Ci0tPiBsdHRuZ19jcmVhdGVfc2Vzc2lvbl9hZGRyKGNvbnN0
IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKmFkZHIsCgkJCQkJCQkJaW50IGVuYWJsZV9jb25z
dW1lcik7CgpUaGUgX25hbWVfIGFyZ3VtZW50IGlzIHRoZSBzZXNzaW9uIG5hbWUgYW5kIF9h
ZGRyXyBpcyBhIHN0cmluZyByZXByZXNlbnRpbmcgdGhlClVSTCBzcGVjaWZpZWQgYnkgdGhl
IHVzZXIgd2hpY2ggbG9va3MgbGlrZSB0aGlzOgoKUFJPVE86Ly9bSE9TVHxJUF1bOlBPUlRd
Wy9QQVRIXQoKRXhhbXBsZXM6CgoqIG5ldDovL215aG9zdG5hbWUKKiBuZXQ6Ly9teWhvc3Ru
YW1lOjk4ODgKKiBuZXQ6Ly9teWhvc3RuYW1lL2Zvby9iYXIKKiBuZXQ6Ly9YLlguWC5YOjk4
ODgvZm9vL2JhcgoKVGhlIGVuYWJsZV9jb25zdW1lciBvcHRpb24gd2lsbCBkaXNhYmxlIHRo
ZSB1c2Ugb2YgdGhlIGNvbnN1bWVyIGZvciB0aGUgdHJhY2luZwpzZXNzaW9uLiBUaGlzIHdp
bGwgYmUgdXNlZnVsIHdpdGggdGhlIHRvIGNvbWUgc25hcHNob3QgZmVhdHVyZS4gVGhlIG1v
dGl2YXRpb24KYmVoaW5nIHRoaXMgZmxhZyBpcyB0byBvZmZlciB0aGUgc2FtZSBvcHRpb25z
IGFzIHRoZSBlbmFibGUtY29uc3VtZXIgY29tbWFuZAp3aGVyZSB5b3UgY2FuIG9ubHkgc2V0
IHRoZSBVUkkgZm9yIHRoZSBjb25zdW1lciBhbmQgbm90IGVuYWJsZSBpdC4KClsqXSBDb25z
dW1lcjoKClRoZSBjdXJyZW50IGx0dG5nX3NldF9jb25zdW1lcl91cmkoLi4uKSBjYWxsIHdp
bGwgYmUgY2hhbmdlZCB0bzoKCmx0dG5nX3NldF9jb25zdW1lcl9hZGRyKHN0cnVjdCBsdHRu
Z19oYW5kbGUgKmhhbmRsZSwKCQkJCWNvbnN0IGNoYXIgKmFkZHIpOwoKRm9yIGJvdGggZnVu
Y3Rpb25zIChjb25zdW1lciBhbmQgY3JlYXRlKSwgdGhlIGFkZHIgd2lsbCBiZSB0cmFuc2xh
dGUgdG8gYQpsdHRuZ191cmkgaW4gdGhlIGxpYmx0dG5nLWN0bCBhbmQgc2VudCB0byB0aGUg
c2Vzc2lvbiBkYWVtb24uCgpXaXRoIGFsbCB0aGlzLCB0aGUgbHR0bmdfdXJpIGRhdGEgc3Ry
dWN0dXJlIHdpbGwgbm90IGJlIGV4cG9zZWQgdG8gdGhlIHB1YmxpYwpBUEkgYW5kIHRoZSB1
c2VyIGNvbW1hbmQgbGluZSBpbnRlcmZhY2UuCg==
--------------030203090508040503010803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030203090508040503010803--
