package com.project.backend;

import java.io.FileInputStream;
import java.io.IOException;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class FileChecksum {
	public static final String MD2 = "MD2";
	public static final String MD5 = "MD5";
	public static final String SHA = "SHA";
	public static final String SHA_256 = "SHA-256";
	public static final String SHA_384 = "SHA-384";
	public static final String SHA_512 = "SHA-512";

	public static String checksum(String filePath, String algorithm) {
		MessageDigest messageDigest = null;

		// file hashing with DigestInputStream
		try {
			messageDigest = MessageDigest.getInstance(algorithm);
			DigestInputStream digestInputStream = new DigestInputStream(new FileInputStream(filePath), messageDigest);
			while (digestInputStream.read() != -1);	// empty loop to clear the data
			messageDigest = digestInputStream.getMessageDigest();
			digestInputStream.close();
		} catch (NoSuchAlgorithmException e) {
			System.out.println("FileChecksum: There are an error: " + e.toString());
			return null;
		} catch (IOException e) {
			System.out.println("FileChecksum: There are an error: " + e.toString());
			return null;
		}

		// bytes to hex
		StringBuilder result = new StringBuilder();

		for (byte b : messageDigest.digest()) {
			result.append(String.format("%02x", b));
		}

		return result.toString();
	}
}
