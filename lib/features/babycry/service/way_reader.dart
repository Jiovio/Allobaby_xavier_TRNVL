import 'dart:io';
import 'dart:typed_data';

class WavReader {

  static Future<Map<String, dynamic>> readWav(String filePath) async {
    try {
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      final buffer = bytes.buffer;
      final byteData = ByteData.view(buffer);


      final riff = String.fromCharCodes(bytes.sublist(0, 4));
      if (riff != 'RIFF') {
        throw Exception('Invalid WAV file: RIFF header not found');
      }

      // Get file size
      final fileSize = byteData.getInt32(4, Endian.little);

      // Check WAVE header
      final wave = String.fromCharCodes(bytes.sublist(8, 12));

      print("Wave Test - ${wave.toString()}");
      if (wave != 'WAVE') {
        throw Exception('Invalid WAV file: WAVE header not found');
      }

      // Read format chunk
      final fmt = String.fromCharCodes(bytes.sublist(12, 16));

      print("FMT Test - ${fmt.toString()}");
      if (fmt != 'fmt ') {
        throw Exception('Invalid WAV file: fmt header not found');
      }

      // Get format chunk size
      final formatChunkSize = byteData.getInt32(16, Endian.little);

      // Get audio format (1 = PCM)
      final audioFormat = byteData.getInt16(20, Endian.little);
      if (audioFormat != 1) {
        throw Exception('Only PCM format is supported');
      }

      // Get number of channels
      final numChannels = byteData.getInt16(22, Endian.little);

      // Get sample rate
      final sampleRate = byteData.getInt32(24, Endian.little);

      // Get byte rate
      final byteRate = byteData.getInt32(28, Endian.little);

      // Get block align
      final blockAlign = byteData.getInt16(32, Endian.little);

      // Get bits per sample
      final bitsPerSample = byteData.getInt16(34, Endian.little);

      // Find data chunk
      int dataOffset = 36;
      while (dataOffset < bytes.length - 4) {
        final chunk = String.fromCharCodes(bytes.sublist(dataOffset, dataOffset + 4));
        if (chunk == 'data') {
          break;
        }
        dataOffset += 4;
        final chunkSize = byteData.getInt32(dataOffset, Endian.little);
        dataOffset += 4 + chunkSize;
      }

      if (dataOffset >= bytes.length - 4) {
        throw Exception('Invalid WAV file: data chunk not found');
      }

      // Get data chunk size
      final dataSize = byteData.getInt32(dataOffset + 4, Endian.little);

      // Read samples
      final samples = <double>[];
      int offset = dataOffset + 8;

      while (offset < dataOffset + 8 + dataSize) {
        if (bitsPerSample == 16) {
          // Convert 16-bit samples to double
          final sample = byteData.getInt16(offset, Endian.little);
          samples.add(sample / 32768.0); // Normalize to [-1.0, 1.0]
          offset += 2;
        } else if (bitsPerSample == 32) {
          // Convert 32-bit samples to double
          final sample = byteData.getInt32(offset, Endian.little);
          samples.add(sample / 2147483648.0); // Normalize to [-1.0, 1.0]
          offset += 4;
        } else {
          throw Exception('Unsupported bits per sample: $bitsPerSample');
        }
      }

      return {
        // 'samples': samples,
        'sampleRate': sampleRate,
        'numChannels': numChannels,
        'bitsPerSample': bitsPerSample,
        'duration': samples.length / sampleRate,
      };
    } catch (e) {
      throw Exception('Error reading WAV file: $e');
    }
  }
}